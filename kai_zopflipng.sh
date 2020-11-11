#!/bin/sh

ZOPFLIPNG="${HOME}/Scripts/zopflipng"

FAILED="[FAILED]"
OK="[  OK  ]"

if [ ! -e "${ZOPFLIPNG}" ]; then
 echo "Please Install zopflipng at ${ZOPFLIPNG}"
 exit 2
fi

if [ ! -d OK/ ]; then
    mkdir OK
fi

# OS Type Check
if [ -f /usr/bin/uname ]; then
    OS=$(/usr/bin/uname)
fi

for fileName in "$@"
do
    origFileSize=$(ls -lh "${fileName}" | awk '{print $5}')

    # Get file modified date
    if [ "${OS}" = 'Linux' ]; then
	fileDate=$(stat --format "%y" "$1" | tr -d ': -' | cut -b -14 | sed -e 's/\(.\{12\}\)/\1./g')
    else
	fileDate=$(stat -t '%Y%m%d%H%M.%S' "$1" |awk '{print $10}' | sed -e 's/"//g')
    fi
    
    ${ZOPFLIPNG}  --iterations=5 -y "${fileName}" "${fileName}"
    #${ZOPFLIPNG} -m  -y ${fileName} ${fileName}
    retval=$?
    touch -t "${fileDate}" "${fileName}"
    
    newFileSize=$(ls -lh "${fileName}" | awk '{print $5}')
    
    if [ ${retval} -eq 0 ]; then
	# Successed
	# Get Filesize 
	echo "${OK} ${fileName} ${origFileSize}B -> ${newFileSize}B "
	mv "${fileName}" OK/
    else
	echo "${FAILED} ${fileName}" >&2
    fi

    unset fileDate
done
