#!/bin/bash

# Update and install required packages
update_packages()
{
echo "*******************  UPDATE PACKAGES"
sudo yum update -y
sudo yum install httpd mlocate mailx wget curl git openscap-scanner scap-security-guide -y
echo "*******************  FINISHED PACKAGES"
}

webpage()
{
echo "*******************  UPDATE INDEX.HTML"
sudo cat > /var/www/html/index.html <<EOF
<!doctype html>
<title>Site Maintenance</title>
<style>
  body { text-align: center; padding: 150px; }
  h1 { font-size: 50px; }
  body { font: 20px Helvetica, sans-serif; color: #333; }
  article { display: block; text-align: left; width: 650px; margin: 0 auto; }
  a { color: #dc8100; text-decoration: none; }
  a:hover { color: #333; text-decoration: none; }
</style>
<article>
    <h1>We&rsquo;ll be back soon!</h1>
    <div>
        <p>Sorry for the inconvenience but we&rsquo;re performing some maintenance at the moment. If you need to you can always <a href="mailto:#">contact us</a>, otherwise we&rsquo;ll be back online shortly!</p>
        <p>&mdash; The Team</p>
    </div>
</article>
EOF
echo "*******************  FINISHED INDEX.HTML UPDATE"
}

start_httpd()
{
echo "*******************  START HTTPD"
sudo systemctl start httpd
echo "*******************  END START HTTPD"
}

openscap_report()
{
echo "*******************  Run openscap report"
sudo oscap xccdf eval \
 --profile xccdf_org.ssgproject.content_profile_ospp42 \
 --results-arf arf.xml \
 --report common-report.html \
 /usr/share/xml/scap/ssg/content/ssg-rhel7-ds.xml
sudo mkdir -p /var/www/html/reports
echo "*******************  END OPENSCAP REPORT"
}

pre_report()
{
sudo cp common-report.html /var/www/html/reports/pre-common-report.html
}

post_report()
{
sudo cp common-report.html /var/www/html/reports/post-common-report.html
}

audit_rules()
{
yes | sudo cp /usr/share/doc/audit-2.8.5/rules/30-stig.rules /etc/audit/rules.d/audit.rules
sudo service auditd restart
}

#run the functions:
update_packages
webpage
start_httpd
openscap_report
pre_report
audit_rules
openscap_report
post_report
