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
        
        if (latitude == null && longitude == null) {
        	 request.setAttribute("latitude", "34.067701");
        	 request.setAttribute("longitude", "-118.12404");
        } else {
        	 request.setAttribute("latitude", latitude);
             request.setAttribute("longitude", longitude);
        }
        request.setAttribute("radius", radius);
        
        if (radius != null && radius.equals("")) {
            radius = "20";
        }
        
        if (latitude != null && longitude != null) {
            double lat = Double.parseDouble(latitude);
            double lng = Double.parseDouble(longitude);
            double r = Integer.parseInt(radius) / 0.000621371192;  // Mile to meter
            
            // request for list of places
            String str = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?" + 
                    "location=" + lat + ",%20" + lng + 
                    "&radius=" + r +
                    "&key=AIzaSyDv_0sVA5OuZzQuulNUuP6gkYKMWt88vwk";
            URL requestURL = new URL(str);
            Scanner scan = new Scanner(requestURL.openStream());
            String places_info = new String();
            
            // scan returned json to string
            while (scan.hasNext())
                places_info += scan.nextLine();
            scan.close();
            
            // using string create JSONObject
            JSONObject obj = new JSONObject(places_info);
            // get results(places)
            JSONArray anchors = obj.getJSONArray("results");
            ArrayList<String> places_id = new ArrayList<>();
            
            // put place id in to a list
            for (int i = 0; i < anchors.length(); i++) {
                JSONObject anchor = anchors.getJSONObject(i);
                places_id.add(anchor.getString("place_id"));
            }
            ArrayList<POI> pois = new ArrayList<>();
            
            // request for place detail using places id and put info into POI list
            for(String id : places_id) {
            	URL requestDetailURL = new URL("https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyDv_0sVA5OuZzQuulNUuP6gkYKMWt88vwk&placeid=" + id);
            	scan = new Scanner(requestDetailURL.openStream());
            	String placeDetial = new String();
            	while (scan.hasNext())
            		placeDetial += scan.nextLine();
            	scan.close();
            	JSONObject info = new JSONObject(placeDetial);
            	info = info.getJSONObject("result");
            	JSONObject location = info.getJSONObject("geometry").getJSONObject("location");
            	String phone = (info.has("formatted_phone_number")) ? info.getString("formatted_phone_number") : "N/A";
            	String types = info.get("types").toString();
            	types = types.substring(1, types.length()-1);
            	types = types.replaceAll("\"", "");
                pois.add(new POI(info.getString("name"), 
                		String.valueOf(location.getDouble("lat")), String.valueOf(location.getDouble("lng")), 
                		info.getString("formatted_address"), phone,  types));
            }
            request.setAttribute("places", pois);
        }

        request.getRequestDispatcher("/WEB-INF/EC/Search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        doGet(request, response);
    }
}
