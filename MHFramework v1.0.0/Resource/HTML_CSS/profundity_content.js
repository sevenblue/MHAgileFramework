function setFontSize(size){
	var objname = 'detail';
    var whichEl = document.getElementById(objname);
	whichEl.style.fontSize=size+'px';
}

function setPaddingTop(topHeight) {
	var objname = 'title_section';
    var whichEl = document.getElementById(objname);
    whichEl.style.paddingTop=topHeight + 5 +'px';
}

