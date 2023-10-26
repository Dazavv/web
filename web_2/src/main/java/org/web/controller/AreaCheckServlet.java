package org.web.controller;

import org.web.model.Point;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AreaCheckServlet", value = "/check")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");

        List<String> tableRows = (List) session.getAttribute("tableRows");
        if (tableRows == null) {
            tableRows = new ArrayList<String>();
            session.setAttribute("tableRows", tableRows);
            tableRows.add("<table id='outputTable'><tr>" +
                    "<caption>Чеклист</caption>" +
                    "<th>X</th>" +
                    "<th>Y</th>" +
                    "<th>R</th>" +
                    "<th>попадание</th>" +
                    "<th>текущее время</th></tr>");
        }

        int x = Integer.parseInt(request.getParameter("x"));
        float y = Float.parseFloat(request.getParameter("y"));
        float r = Float.parseFloat(request.getParameter("r"));
        String currentTime = LocalTime.now().format(DateTimeFormatter.ofPattern("kk:mm:ss"));

        PrintWriter writer = response.getWriter();


        tableRows.add(new Point(x, y, r, check(x, y, r), currentTime).toString());
        for (String tableRow: tableRows) writer.println(tableRow);
        writer.close();
    }

    public boolean check(int x, float y, float r){
        //квадрат
        if (x <= r && y >= (-1)*r && x >= 0 && y <= 0) return true;
        //треугольник
        if (x >= 0 && y >= 0 && (x + y) <= 4) return true;
        //четверть круга
        if (x <= 0 && y >= 0 && (x*x + y*y) <= r * r/4) return true;
        else return false;
    }
}
