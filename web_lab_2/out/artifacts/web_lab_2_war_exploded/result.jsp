<%--
  Created by IntelliJ IDEA.
  User: dasha
  Date: 27.10.2023
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Point" %>
<%List<Point> tableRows = (List<Point>) session.getAttribute("tableRows");%>
<html>
<head>
    <title>Result</title>
    <style>
        #res {
            border: 1px solid gray;
            border-collapse: collapse;
            margin: auto;
            width: 970px;
        }
        th  {
            border: 1px solid grey;
            padding: 10px 10px;
            font-weight: normal;
            background-color: #ddd;
        }
        td {
            border: 1px solid grey;
            padding: 10px 10px;
            font-weight: normal;
            text-align: center;
        }
        input[type="button"] {
            background-color: #333;
            color: #fff;
            border: none;
            cursor: pointer;
            /*padding: 4px 16px;*/
            text-align: center;
            font-size: 17px;
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
<table id="res">
    <caption>Чеклист</caption>
    <tr>
        <th>X</th>
        <th>Y</th>
        <th>R</th>
        <th>попадание</th>
        <th>текущее время</th>
    </tr>
    <%
        if (tableRows != null && !tableRows.isEmpty()) {
            Point lastPoint = tableRows.get(tableRows.size() - 1);
    %>
    <tr>
        <td class="x_cell"><%= lastPoint.getX() %>
        </td>
        <td class="y_cell"><%= lastPoint.getY() %>
        </td>
        <td class="r_cell"><%= lastPoint.getR() %>
        </td>
        <td><%= lastPoint.getInside()%>
        </td>
        <td><%= lastPoint.getLocalTime() %>
        </td>
    </tr>
    <%}%>
</table>
<input type="button" onclick="window.location.href='index.jsp'" value="Назад"/>
</body>
</html>

