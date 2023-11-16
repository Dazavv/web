package org.example.controller;

import org.example.model.Point;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
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

        List<Point> tableRows = (List) session.getAttribute("tableRows");
        if (tableRows == null) {
            tableRows = new ArrayList<Point>();
            session.setAttribute("tableRows", tableRows);
        }

        int x = Integer.parseInt(request.getParameter("x"));
        float y = Float.parseFloat(request.getParameter("y"));
        float r = Float.parseFloat(request.getParameter("r"));
        String currentTime = LocalTime.now().format(DateTimeFormatter.ofPattern("kk:mm:ss"));

        Point point = new Point(x, y, r, check(x, y, r), currentTime);
        tableRows.add(point);
        request.setAttribute("tableRows", point);
        request.getRequestDispatcher("/result.jsp").forward(request, response);
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
