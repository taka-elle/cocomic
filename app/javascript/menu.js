function pullDown(){

  const pullDownButton = document.getElementById("user-name")
  const pullDownParents = document.getElementById("pull-down")

  pullDownButton.addEventListener('mouseover', function(){
    this.setAttribute("style", "color:#FFBEDA;")
  });

  pullDownButton.addEventListener('mouseout', function(){
    this.removeAttribute("style", "color:#FFBEDA;")
  });

  pullDownButton.addEventListener('click', function() {
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;")
    } else {
      pullDownParents.setAttribute("style", "display:block;")
    };
  });
};

window.addEventListener('load', pullDown);