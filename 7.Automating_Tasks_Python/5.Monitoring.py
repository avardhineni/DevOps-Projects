import psutil
import datetime

# Get the CPU usage
cpu_percent = psutil.cpu_percent()

# Get the system load average
load_avg = psutil.getloadavg()

# Get the disk usage
disk_usage = psutil.disk_usage('/')

# Get the memory usage
mem = psutil.virtual_memory()
mem_total = mem.total
mem_used = mem.used

# Get the system uptime
uptime = datetime.timedelta(seconds=psutil.boot_time())

# Print the results
print(f"CPU usage: {cpu_percent}%")
print(f"Load average: {load_avg}")
print(f"Disk usage: {disk_usage.used} / {disk_usage.total} ({disk_usage.percent}%)")
print(f"Memory usage: {mem_used} / {mem_total} ({mem.percent}%)")
print(f"System uptime: {uptime}")
