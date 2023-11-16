<%--
  Created by IntelliJ IDEA.
  User: dasha
  Date: 24.10.2023
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.model.Point" %>
<%@ page import="java.util.List" %>
<%List<Point> tableRows = (List<Point>) session.getAttribute("tableRows");%>

<html>
<head>
    <meta charset="utf-8">
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <title>web-2</title>
    <style>
        div {
            margin: 10px;
            border: 1px solid black;
            font-size: 20px;
        }
        #header {
            border: 1px solid black;
            margin: 10px;
            height: 80px;
            background-color: #ddd;
            font-family: monospace;
            align-items: center;
            text-align: center;
            display: flex;
            justify-content: center;
            font-size: 20px;
        }
        svg, #svg {
            width: 500px;
            height: 350px;
            margin: 15px 55px 15px 45px;
            border: none;
        }
        .graph-block {
            background-color: #ddd;
            float: left;
            width: 500px;
            height: 600px;
            text-align: left;
        }
        .buttons {
            text-align: left;
            height: auto;
            border: none;
            line-height: 20px;
        }
        .coor {
            border: none;
            padding-top: 0;
            height: 40px;
        }
        .inputs {
            height: 40px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 30px;
            width: 230px;
            border: none;
        }
        .error {
            color: red;
            font-size: 15px;
            margin-top: 0;
        }
        input[type="submit"] {
            background-color: #333;
            color: #fff;
            border: none;
            cursor: pointer;
            padding: 4px 16px;
            float: left;
            font-size: 17px;
        }
        input[type="reset"] {
            background-color: #333;
            color: #fff;
            text-align: center;
            float: right;
            margin-bottom: 10px;
            border: none;
            cursor: pointer;
            padding: 4px 16px;
            font-size: 17px;
        }
        /* псевдокласс */
        select:invalid {
            color: gray;
        }
        #result {
            border: 1px solid gray;
            float: right;
            margin-right: 10px;
            width: 970px;
            border-collapse: collapse;

        }
        th {
            border: 1px solid grey;
            width: 25px;
            padding: 10px 10px;
            font-weight: normal;
            background-color: #ddd;
        }
        td {
            border: 1px solid grey;
            width: 25px;
            padding: 10px 10px;
            font-weight: normal;
            text-align: center;
        }
        caption {
            caption-side: top;
            text-align: center;
            padding: 10px 0;
            font-size: 25px;
        }
    </style>
</head>
<body>
<div id="header">
    Завацкая Дарья Вадимовна P3234<br>Вариант: 3410
</div>

<div class="graph-block">
    <div id="svg">
        <svg xmlns="http://www.w3.org/2000/svg">
        <line x1="0" y1="150" x2="300" y2="150" stroke="#000720"></line>
        <line x1="150" y1="0" x2="150" y2="300" stroke="#000720"></line>
        <line x1="270" y1="148" x2="270" y2="152" stroke="#000720"></line>
        <text x="265" y="140">R</text>
        <text x="290" y="140">x</text>
        <text x="200" y="140">R/2</text>
        <text x="75" y="140">-R/2</text>
        <text x="20" y="140">-R</text>
        <text x="156" y="35">R</text>
        <text x="156" y="10">y</text>
        <text x="156" y="95">R/2</text>
        <text x="156" y="215">-R/2</text>
        <text x="156" y="275">-R</text>
        <polygon points="300,150 295,155 295, 145" fill="#000720" stroke="#000720"></polygon>
        <polygon points="150,0 145,5 155,5" fill="#000720" stroke="#000720"></polygon>
        <%--треугольник done--%>
        <polygon points="270,150 150,150 150,30" fill-opacity="0.4" stroke="navy" fill="blue"></polygon>
        <%--квадрат done--%>
        <rect x="150" y="150" width="120" height="120" fill-opacity="0.4" stroke="navy" fill="blue"></rect>
        <%--четверть круга--%>
        <path d="M150 150 L90 150 C90 120 120 90 150 90 L Z" fill-opacity="0.4" stroke="navy" fill="blue"></path>
        </svg>
    </div>
<div class="buttons">

    <form id="form-with-validation" method="post" >
        <div class="coor"><label>изменение X:</label>
            <label><input type="radio" name="x" class="checkbox-x" value="-3">-3</label>
            <label><input type="radio" name="x" class="checkbox-x" value="-2">-2</label>
            <label><input type="radio" name="x" class="checkbox-x" value="-1">-1</label>
            <label><input type="radio" name="x" class="checkbox-x" value="0">0</label>
            <label><input type="radio" name="x" class="checkbox-x" value="1">1</label>
            <label><input type="radio" name="x" class="checkbox-x" value="2">2</label>
            <label><input type="radio" name="x" class="checkbox-x" value="3">3</label>
            <label><input type="radio" name="x" class="checkbox-x" value="4">4</label>
            <label><input type="radio" name="x" class="checkbox-x" value="5">5</label>
            <p class="error" id="error-x"></p>
        </div>

        <div class="coor"><label for="y">изменение Y:</label>
            <input type="text" id="y" name="y" placeholder="введите число [-5; 5]" maxlength="5" oninput="this.value = this.value.replace(/[^0-9.-]/g, '');" required autocomplete="off">
            <p class="error" id="error-y"></p>
        </div>
        <div class="coor"><label for="r">изменение R:</label>
            <input type="text" id="r" name="r" placeholder="введите число [1; 4]" maxlength="5" oninput="this.value = this.value.replace(/[^0-9.-]/g, '');" required autocomplete="off">
            <p class="error" id="error-r"></p></div>
        <div class="inputs">
            <input type="submit" class="button-check" value="проверить">
            <input type="reset" value="сбросить" onclick="resetError()"></div>

    </form>
</div></div>
<table class="table" id="result">
    <caption>Чеклист</caption>
    <tr>
        <th>X</th>
        <th>Y</th>
        <th>R</th>
        <th>попадание</th>
        <th>текущее время</th>
    </tr>
    <%
        if (tableRows != null)
            for (Point tableRow : tableRows) {
    %>
    <tr>
        <td class="x_cell"><%= tableRow.getX() %>
        </td>
        <td class="y_cell"><%= tableRow.getY() %>
        </td>
        <td class="r_cell"><%= tableRow.getR() %>
        </td>
        <td><%= tableRow.getLocalTime()%>
        </td>
        <td><%= tableRow.getInside() %>
        </td>
    </tr>
    <%}%>
</table>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="logic.js"></script>
</body>
</html>
