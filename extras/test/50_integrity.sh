#!/usr/bin/env zsh

export test_description="Testing file integrity"

source ./setup

test_export "test" # Using already generated tomb
test_expect_success 'Testing contents integrity' '
    tt_open --tomb-pwd $DUMMYPASS &&
    tomb_set_ownership "$MEDIA/$USER/$testname" &&
    tt dig -s 10 "$MEDIA/$USER/$testname/datacheck.raw" &&
    CRC1=$(sha256sum "$MEDIA/$USER/$testname/datacheck.raw") &&
    tt_close --unsafe &&
    tt_open --tomb-pwd $DUMMYPASS &&
    CRC2=$(sha256sum "$MEDIA/$USER/$testname/datacheck.raw") &&
    [[ "$CRC1" == "$CRC2" ]] &&
    tt_close
    '

test_done
