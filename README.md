# OverrideEDID

## About
A recent bug has caused certain apps to "stutter" the mouse on startup. Some reddit posts have been made where the user belives its the monitor causing it. [HERE](https://www.reddit.com/r/nvidia/comments/18jdogj/psa_you_may_be_experiencing_stutters_due_to_your/). He then posts a fix which is sort of right [HERE](https://www.reddit.com/r/nvidia/comments/198is3r/update_lg_monitors_causing_stuttering_fix/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button). However only one part of the fix is needed and the rest can be ignored.

## The Issue
When opening some apps Ex. Discord a call to the monitors driver is made to read the EDID blocks 1-3 [Source](https://learn.microsoft.com/en-us/windows-hardware/drivers/display/overriding-monitor-edids#overriding-an-edid-with-an-inf). This means we can just clear out block 1's data to get rid of the interrupt that occurs when reading it (Kinda, there is still some data to be read). 

## Before Fix




## After Fix