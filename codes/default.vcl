vcl 4.0;

backend default {
    .host = "127.0.0.1";
    .port = "9000";
}

sub vcl_recv {
#	set req.http.X-Cookie=req.http.Cookie;
#	unset req.http.Cookie;
	if(req.url ~ "^/api/vod/" || req.url ~ "^/api/asset/" || req.url ~ "^/api/health/" || 
		req.url ~ "^/api/linear/" || req.url ~ "^/asset" || req.url ~ "^/partials/" ||
		req.url ~ "^/extensions/" || req.url ~ "^/bower_components/" || req.url ~ "^/scripts/" || req.url ~ "^/images/"){
		set req.http.X-Cookie=req.http.Cookie;
		unset req.http.Cookie;
		return(hash);
	}
	if(req.url ~ "^/api/configuration"){
		set req.http.X-Cookie=req.http.Cookie;
		unset req.http.Cookie;
		return(hash);
	}
	return(pass);
}

sub vcl_hash {
	hash_data(req.url);
	if(req.http.host){
		hash_data(req.http.host);
	}
	return(lookup);
}

sub vcl_hit {
	return(deliver);
}

sub vcl_miss {
	return(fetch);
}

sub vcl_pass {
	return(fetch);
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    # 
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
	if(bereq.url ~ "^/api/configuration"){
		#unset bereq.http.Cookie;
		set beresp.ttl = 24h;
	}
    return(deliver);
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    # 
    # You can do accounting or modifying the final object here.
	return(deliver);
}

