# Lemmy CI/CD pipeline

<a href="https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/lemmy"><img src="deploy-on-elestio.png" alt="Deploy on Elest.io" width="180px" /></a>

Deploy Lemmy server with CI/CD on Elestio

<img src="lemmy.png" style='width: 100%;'/>
<br/>
<br/>

# Once deployed ...

You can open Lemmy UI here:

    URL: https://[CI_CD_DOMAIN]
    email: admin
    password: [ADMIN_PASSWORD]



# Custom domain instructions (IMPORTANT)

By default we setup a CNAME on elestio.app domain, but probably you will want yo have your own domain.

***Step1:*** add your domain in Elestio dashboard as explained here:

    https://docs.elest.io/books/security/page/custom-domain-and-automated-encryption-ssltls

***Step2:*** update the env vars to indicate your custom domain
Open Elestio dashboard > Service overview > click on UPDATE CONFIG button > Env tab
there update `DOMAIN` & `BASE_URL` with your real domain

***Step3:*** you must set your custom domain in `/opt/app/config.hjson` (you can do that with File editor of VSCode in our tools tab)

***Step4:*** you must reset the Lemmy instance DB, you can do that with those commands, connect over SSH and run this:

    cd /opt/app;
    docker-compose down;
    rm -rf ./pgdata;
    rm -rf ./pictrs;
    mkdir -p ./pictrs
    chown -R 991:991 ./pictrs
    docker-compose up -d;

You will start over with a fresh instance of Lemmy directly configured with the correct custom domain name and federation will work as expected

