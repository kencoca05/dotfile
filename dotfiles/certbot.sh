sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-apache
sudo certbot --apache -d example.com
sudo certbot --apache -d example.com -d www.example.com
sudo certbot renew --dry-run
