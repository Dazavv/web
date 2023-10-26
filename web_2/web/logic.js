var patternFloatY = /^[+-]?[0-4](\.[0-9]+)|^5(\.0+)?$/;
var patternIntY = /^([+-]?[0-5])$/;
var patternFloatR = /^[1-3](\.[0-9]+)|^4(\.0+)?$/;
var patternIntR = /^[1-4]$/;

var outOfSpace = true;
//обработка данных из формы
document.getElementById('form-with-validation').addEventListener('submit', function (e) {
  e.preventDefault();
  check();
});

//обработка данных из SVG
document.getElementById('svg').addEventListener('click', function (e) {

  let svg = document.querySelector('svg');
  let pt = svg.createSVGPoint();
  let r = document.getElementById('r');
  pt.x = e.clientX;
  pt.y = e.clientY;
  let svgP = pt.matrixTransform(svg.getScreenCTM().inverse());

  sendSVG(svgP.x, svgP.y, r);
  // drawPoint(svgP.x, svgP.y, r);
  if (!outOfSpace) {
    let circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
    circle.setAttribute("cx", svgP.x);
    circle.setAttribute("cy", svgP.y);
    circle.setAttribute("r", "3");
    circle.setAttribute("fill", "red");
    svg.appendChild(circle);
  }
});
function drawPoint(x, y, r) {
  let circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
  circle.setAttribute("cx", x);
  circle.setAttribute("cy", y);
  circle.setAttribute("r", "3");
  circle.setAttribute("fill", "red");
  svg.appendChild(circle);
}

function sendSVG(x, y, r) {
  if (r.value.length === 0) {
    outOfSpace = true;
    document.getElementById("error-r").textContent = "R не выбран";
    return;
  }
  let radius = r.value;
  let svgX = Math.round((x - 150) / 120 * radius).toFixed(0);
  let svgY = ((150 - y) / 120 * radius).toFixed(5);

  if (!(svgX >= -3 && svgX <= 5 && svgY >= -5 && svgY <= 5)) {
    outOfSpace = true;
    document.getElementById("error-r").textContent = "Выход значений за пределы допустимого";
    //Выход значений за пределы допустимого
    return;
  }
  outOfSpace = false;
  document.getElementById("error-r").textContent = " ";
  send(svgX, svgY, radius);
}

function check(){
  var r = document.getElementById('r').value;
  var y = document.getElementById('y').value;
  var radio = document.querySelectorAll('input[type="radio"]:checked')[0];
  var x = radio.value;

  if (validateY(y) && validateR(r)) {
    send(x, y, r);
  }

}

function send(x, y, r){
  var params = new URLSearchParams('x=' + x + '&y=' + y + '&r=' + r);

  fetch('c', {
    method: 'POST',
    body: params
  }).then(
      response => {
        return response.text();
      }
  ).then(
      text => {
        document.getElementById('result').innerHTML = text;
      }
  );
}

function validateY(y) {
  if (patternFloatY.test(y)) {
    y = parseFloat(y);
    document.getElementById("error-y").textContent = "";
    return true;
  }
  if (patternIntY.test(y)) {
    y = parseInt(y);
    document.getElementById("error-y").textContent = "";
    return true;
  } else {
    document.getElementById("error-y").textContent = "Y должен быть в диапазоне от -3 до 5";
    return false;
  }
}

function validateR(r) {
  if (patternFloatR.test(r)) {
    r = parseFloat(r);
    document.getElementById("error-r").textContent = "";
    return true;
  }
  if (patternIntR.test(r)) {
    r = parseInt(r);
    document.getElementById("error-r").textContent = "";
    return true;
  } else {
    document.getElementById("error-r").textContent = "R должен быть в диапазоне от 1 до 4";
    return false;
  }
}

function resetError() {
  document.getElementById("error-y").textContent = "";
  document.getElementById("error-x").textContent = "";
}