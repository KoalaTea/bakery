# needed folders
influxdbdata

# notes

the mounted directories if created by the mount are root:root and not writable by a non root user so need to make sure the file system allows 777 or in synology Everyone Write to allow the container to write to it

# influx 3 (And why we dont use it)
influxdb3 uses avx cpu instructions which are not available to the synology cpu cat /proc/cpuinfo (FLAGS:) has no avx
so cannot use influxdb3
influxdb:3-core
in synology need to do command: since any version of entrypoint does not work. But maybe this will change in one that has a more modern cpu with avx allows influxdb anyways.
```yaml
command:
- influxdb3
- serve
- --node-id=node0
- --object-store=file
- --data-dir=/var/lib/influxdb3/data
```