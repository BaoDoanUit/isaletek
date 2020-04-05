(function() {
    var accessibilityConstants = {
        cbPronounceElementID: "cbPronounceElement",
        cbMessage: "Callback in the process"
    }
    function beginCallback(s, e) {
        var control = e.control;
        if (!isSupportedControl(control))
            return;
        control.cpFocusTreeLine = getFocusTreeLine(control);
        var pronounceElement = createCallbackPronounceElement(control.GetMainElement());
        pronounceElement.focus();
    }
    function isSupportedControl(control) {
        return (typeof(ASPxClientGridView) != "undefined" && control instanceof ASPxClientGridView) ||
            (typeof(ASPxClientCardView) != "undefined" && control instanceof ASPxClientCardView) ||
            (typeof(ASPxClientVerticalGrid) != "undefined" && control instanceof ASPxClientVerticalGrid) ||
            (typeof(ASPxClientTreeList) != "undefined" && control instanceof ASPxClientTreeList) ||
            (typeof(ASPxClientCallbackPanel) != "undefined" && control instanceof ASPxClientCallbackPanel);
    }
    function removeCallbackPronounceElement() {
        var pronounceElement = document.getElementById(accessibilityConstants.cbPronounceElementID);
        if(pronounceElement)
            pronounceElement.parentElement.removeChild(pronounceElement);
    }
    function createCallbackPronounceElement(target) {
        var pronounceElement = document.createElement("DIV");

        pronounceElement.innerHTML = accessibilityConstants.cbMessage;
        setAttribute(pronounceElement, ASPxClientUtils.ie ? "tabIndex" : "tabindex", 0);
        setAttribute(pronounceElement, 'style', 'position:fixed;left:0px;top:0px;clip: rect(1px, 1px, 1px, 1px);-webkit-clip-path: polygon(0 0);');
        pronounceElement.id = accessibilityConstants.cbPronounceElementID;
        var parentElement = target.parentElement;
        parentElement.insertBefore(pronounceElement, target);

        return pronounceElement;
    }
    function setAttribute(obj, attrName, value) {
        if(obj.setAttribute)
            obj.setAttribute(attrName, value);
        else if(obj.setProperty)
            obj.setProperty(attrName, value, "");
    }
    function endCallback(s, e) {
        var control = e.control;
        var focusElement = findFocusElement(control);
        if(focusElement)
            window.setTimeout(function () { focusElement.focus(); }, 200);
        delete control.cpFocusTreeLine;

        removeCallbackPronounceElement();
    }

    function getFocusTreeLine(control) {
        var treeLine = [ ];
        var element = document.activeElement;
        var focusedEditor = ASPx.GetFocusedEditor();
        if(element.tagName === "BODY" && ASPx.IsExists(focusedEditor))
            element = focusedEditor.GetFocusableInputElement();
        
        while(element && element.tagName !== "BODY") {
            treeLine.push({ 
                id: element.id,
                tagName: element.tagName,
                index: ASPxClientUtils.ArrayIndexOf(element.parentNode.childNodes, element)
            });
            if(element === control.GetMainElement())
                return treeLine;
            element = element.parentNode;
        }

        return treeLine;
    }

    function findFocusElement(control) {
        var treeLine = control.cpFocusTreeLine;
        if(!treeLine) return;

        var focusElementParent = findFocusElementParentById(treeLine);
        if(!focusElementParent) 
            return;

        return findFocusElementFromDOMTree(treeLine, focusElementParent);
    }
    function findFocusElementParentById(treeLine) {
        for(var i = 0; i < treeLine.length; i++) {
            var id = treeLine[i].id;
            if(!isValidId(id))
                continue;
            var element = document.getElementById(id);
            if(element) {
                // get first part of tree line and reverse it
                treeLine.splice(i, treeLine.length - i);
                treeLine.reverse();
                return element;
            }
        }
        return null;
    }
    function findFocusElementFromDOMTree(treeLine, focusElementParent) {
        var element = focusElementParent;
        for(var i = 0; i < treeLine.length; i++) {
            var info = treeLine[i];

            if(info.index >= element.childNodes.length) {
                element = element.childNodes.length > 0 ? element.childNodes[element.childNodes.length - 1] : null;
                return findNeighbourFocusElement(element, focusElementParent);
            }

            var child = element.childNodes[info.index];
            if(child.tagName !== info.tagName)
                return findNeighbourFocusElement(child, focusElementParent);

            element = child;
        }
        return element;
    }
    function findNeighbourFocusElement(element, focusElementParent) {
        if(!element) return null;

        var neighbours = element.parentNode.childNodes;
        var indices = calcLeftRightIndices(ASPxClientUtils.ArrayIndexOf(neighbours, element), neighbours.length);

        for(var i = 0; i < indices.length; i++) {
            var index = indices[i];
            var actionElement = findActionElement(neighbours[index]);
            if(actionElement)
                return actionElement;
        }

        if(element === focusElementParent)
            return null;
        return findNeighbourFocusElement(element.parentNode, focusElementParent);
    }

    function calcLeftRightIndices(startIndex, count) {
        var indices = [ ];
        var incSides = [ 0, 0 ];
        var index = startIndex;

        for(var i = 0; i < count; i++) {
            indices.push(index);

            var even = i % 2 === 0;
            var nextIndex = calcNextIndex(startIndex, count, incSides, even);
            if(nextIndex < 0)
                nextIndex = calcNextIndex(startIndex, count, incSides, !even);
            
            index = nextIndex;
        }
        return indices;
    }
    function calcNextIndex(startIndex, count, incSides, even) {
        var sideIndex = even ? 0 : 1;
        var inc = incSides[sideIndex];
        inc += even ? -1 : 1;

        var nextIndex = startIndex + inc;
        if(nextIndex >= 0 && nextIndex < count) {
            incSides[sideIndex] = inc;
            return nextIndex;
        }
        return -1;
    }
    
    var excludedIDs = [ "DXCBtn" ]; // command button id is autogenerated
    function isValidId(id) {
        if(!id) return false;
        for(var i = 0; i < excludedIDs.length; i++) {
            if(id.indexOf(excludedIDs[i]) > -1)
                return false;
        }
        return true;
    }

    function findActionElement(container) {
        var actionElements = [ container ];
        actionElements = actionElements.concat(getElementsByTagName(container, "A"));
        actionElements = actionElements.concat(getElementsByTagName(container, "INPUT"));
        for(var i = 0; i < actionElements.length; i++) {
            var element = actionElements[i];
            if(element.tagName === "A" || element.tagName === "INPUT" && element.type !== "HIDDEN")
                return element;
        }
        return null;
    }

    function getElementsByTagName(element, tagName) {
        var result = [ ];
        if(element && element.getElementsByTagName) {
            var elements = element.getElementsByTagName(tagName.toUpperCase());
            for(var i = 0; i < elements.length; i++)
                result.push(elements[i]);
        }
        return result;
    }

    function attachEvent(element, eventName, func) {
        if(element.addEventListener)
            element.addEventListener(eventName, func, true);
        else
            element.attachEvent("on" + eventName, func);
    }
    attachEvent(document, "DOMContentLoaded", function() {
        ASPxClientControl.GetControlCollection().BeginCallback.AddHandler(beginCallback);
        ASPxClientControl.GetControlCollection().EndCallback.AddHandler(endCallback);
    });
})();