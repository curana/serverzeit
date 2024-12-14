server {
	# Domainnamen dieses vHosts
	server_name example.com www.example.com;

	# vHost-Verzeichnis festlegen
	set $dir example.com;
	listen 80;
	access_log /www/vhosts/$dir/.log/nginx.access.log main; 
	error_log /www/vhosts/$dir/.log/nginx.error.log crit; 

	root /www/vhosts/$dir/htdocs;
  index   index.php index.htm;

	# Logge diese 404-Fehler nicht
	location ~ ^/(robots\.txt|favicon\.ico) {
  	log_not_found   off;
  }
  
  # Zugriff auf .-Files verhindern
  location ~ /\. {
		deny all;
	}

	# Falls die gesuchte Datei existiert, Verarbeitung abkuerzen 
	if (-f $request_filename) {
		break;
	}

	# DocumentRoot
  location / {
  	proxy_pass http://10.0.0.2/; 
  	include proxy.conf; 
		proxy_cache nginx_cache;
		proxy_cache_valid 200   302   60m;
		proxy_cache_valid 404   1m;

		# Expiry-Header fuer Grafiken
		location ~ \.(jp(e)?g|gif|css|png|js)$ {
			access_log   off;
			expires   30d;
		}

		location ^~ /admin/ {
			auth_basic "Restricted";
			auth_basic_user_file /www/vhosts/$dir/basic_auth.conf;
		}
    
		# PHP-Instanz
		location ~ \.php$ {
			fastcgi_pass 10.0.0.2:9000;
			# unix:/var/run/php-example_com.sock; 
			fastcgi_index index.php; 
			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; 
			include fastcgi_params;
		} 
	}
}