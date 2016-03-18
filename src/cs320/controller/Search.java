package cs320.controller;

import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import org.json.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EC/Search")
public class Search extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String GOOGLE_API_KEY = "AIzaSyDv_0sVA5OuZzQuulNUuP6gkYKMWt88vwk";


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	
        String latitude =  request.getParameter("lat"); // request.getParameter("latitude");
        String longitude = request.getParameter("lon"); // request.getParameter("longitude");
        String radius = request.getParameter("radius");
        
        request.setAttribute("latitude", latitude);
        request.setAttribute("longitude", longitude);
        request.setAttribute("radius", radius);
        if (radius == null) {
			radius = "20";
		}
        
        if (latitude != null && longitude != null) {
            double lat = Double.parseDouble(latitude);
            double lng = Double.parseDouble(longitude);
            int r = Integer.parseInt(radius); // TODO Check ratio of input radius to google radius param
            
            String requestURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?" + 
        			"location=" + lat + ",%20" + lng + 
        			"&radius=" + (r * 100) + 
        			"&key=AIzaSyDv_0sVA5OuZzQuulNUuP6gkYKMWt88vwk";

            URL url = new URL(requestURL);
            Scanner scan = new Scanner(url.openStream());
            String jsonStr = new String();
            while (scan.hasNext())
            	jsonStr += scan.nextLine();
            scan.close();
            
            // build a JSON object
            JSONObject obj = new JSONObject(jsonStr);
//            if (!obj.getString("status").equals("OK"))
//                return;
            JSONArray anchors = obj.getJSONArray("results");
            ArrayList<POI> pois = new ArrayList<>();
            for (int i = 0; i < anchors.length(); i++) {
                JSONObject anchor = anchors.getJSONObject(i);
                JSONObject location = anchor.getJSONObject("geometry").getJSONObject("location");
                pois.add(new POI(anchor.getString("name"), location.getDouble("lat"), location.getDouble("lng")));
            }

            request.setAttribute("places", pois);

        }

        request.getRequestDispatcher("/WEB-INF/EC/Search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {      
        doGet(request, response);
    }
}
