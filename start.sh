#!/bin/bash
while read f1; do
    echo "sed -n '$f1' < data/domainawal > /deletedomain" | bash -
    echo "sed -n '$f1' < data/ekstension > /deleteekstension" | bash -
    echo "sed -n '$f1' < data/keyword > /deletekeyword" | bash -    
    echo "sed -n '$f1' < data/niches > /deleteniches" | bash -    
    echo "cat data/passmysql > /deletepassmysql" | bash -
    echo "source build.sh" | bash -
done < "start.txt"
