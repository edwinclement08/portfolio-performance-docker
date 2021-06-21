ls
ls custom-
ls custom-services.d/
ls custom-cont-init.d/
ls
ps aux
exit
ps aux
ls /pot
cd /pot
ls
cd /opt
ls
cd portfolio/
ls
./PortfolioPerformance 
s6-envdir -fn -- /var/run/s6/container_environment PortfolioPerformance $CLI_ARGS
s6-envdir -fn -- /var/run/s6/container_environment ./PortfolioPerformance $CLI_ARGS
exit
