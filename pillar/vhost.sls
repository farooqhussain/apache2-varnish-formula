base:
  '*':
    site:
      name: example
      ServerAlias:  example.com
      ServerName: example.com
      ServerAdmin: webmaster@example.com

      Directory: /var/www/html/example.com
      state: enable