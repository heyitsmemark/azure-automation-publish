FROM mcr.microsoft.com/azure-cli

LABEL "com.github.actions.name"="Azure Automation Publish"
LABEL "com.github.actions.description"="Publishes azure automation runbooks."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="green"
LABEL "repository"="https://github.com/heyitsmemark/azure-automation-publish"
LABEL "homepage"="https://github.com/heyitsmemark/azure-automation-publish"
LABEL "maintainer"="heyitsmemark"

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
