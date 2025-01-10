# Bash script repository
In this repository you will find a lot of scripts and elements to improve or add to Bash course repository


Sometimes it's necessary save the output of the terminal. To do this, add at the end of ~/.bashrc the next lines

```bash
LOGDIR=${HOME}/logs
LOGFILE=${LOGDIR}/$(date +%F.%H:%M:%S).log

if [[ ! -d ${LOGDIR} ]]; then
   mkdir -p ${LOGDIR}
fi

# Starting a script session
if [[ -z $SCRIPT ]]; then
    export SCRIPT=${LOGFILE}
    echo "The terminal output is saving to ${LOGFILE}"
    script -f -q ${SCRIPT}
fi
```
