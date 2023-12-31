var sendValidForm = document.getElementById('form-with-validation');
var patternInt = /^[+-]?[0-3]{1}$/;
var patternFloat = /^[+-]?[0-2](\.[0-9]+)?$/;

sendValidForm.addEventListener('submit', function(e) {
  e.preventDefault();

  var r = document.getElementById('r').value;
  var y = document.getElementById('y').value;
  var checkboxes = document.querySelectorAll('input[name="x"]:checked');
  var x;
  
  function validateY(y){
    if (patternInt.test(y)) {
      y = parseFloat(y);
      document.getElementById("error-y").textContent = "";
      return true;
    }
    if (patternFloat.test(y)) {
      y = parseFloat(y);
      document.getElementById("error-y").textContent = "";
      return true;
    }
    else {
      document.getElementById("error-y").textContent = "Y должен быть в диапазоне от -3 до 3";
      return false;
    }
  }
  function validateX(checkboxes){
    if (checkboxes.length == 0 || checkboxes.length > 1) {
      document.getElementById("error-x").textContent = "выберите один checkbox";
      return false;
    }
    else {
      x = checkboxes[0].value;
      document.getElementById("error-x").textContent = "";
      return true;
    }
  }
  
  if (validateX(checkboxes) && validateY(y)) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'script.php', true);
    xhr.setRequestHeader('content-Type', 'application/x-www-form-urlencoded');
    
    xhr.onreadystatechange = function() {
      if (xhr.readyState == 4 && xhr.status == 200) {
        var response = JSON.parse(xhr.responseText);
        if (response.error) {
          alert(response.error);
        }
        else {
          var table = document.querySelector('table');
          var newRow = table.insertRow(1);
          newRow.innerHTML = '<td>' + response.x + '</td>' + 
          '<td>' + response.y + '</td>' + 
          '<td>' + response.r + '</td>'+ 
          '<td>' + response.result + '</td>'+ 
          '<td>' + response.currentTime + '</td>' + 
          '<td>' + response.workTime + '</td>';
        }
      }
    };
    xhr.send('x=' + x + '&y=' + y + '&r=' + r);
  }
});


function resetError() {
  document.getElementById("error-y").textContent = "";
  document.getElementById("error-x").textContent = "";
}
