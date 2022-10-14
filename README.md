# Element Cron Parser

## Requirements
- Swift 5.5
- Command line tools

## Steps to Run

- Within the root of this project, run the following command
    - `swift build`

- To run with the default input test file i've supplied
    - `cat input.txt | swift run Cron 16:10`

To supply your own test input, run the following command after adding your test input file in the root of the project.

- `cat <inputFile> | swift run Cron <simulatedTime>`
    - inputFile is the file containing the information for the cron parser
    - simulatedTime is the simulated time to run the cron parser in format **HH:mm**
    
input file should have a list of tasks in the following format

```
30 1 /bin/run_me_daily
45 * /bin/run_me_hourly
* * /bin/run_me_every_minute
* 19 /bin/run_me_sixty_times
``` 


## Notes

I've used the Argument Parser dependency supplied by Apple that uses property wrappers.

I've tried to think of majority of scenarios for running a task using the simulated times but could have missed some.

I've used fatalErrors for failure points, these could be moved to an enum named 'CronError', then we could throw the errors instead.

I've quickly wrote a few tests cases but there could be several more added with more time.

I'm relatively happy with the overall layout of the code but there is definite room for improvement with more time and planning.
