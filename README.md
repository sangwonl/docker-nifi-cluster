# docker-nifi-cluster

### Build
```
$ docker build -t sangwonl/nifi-cluster:latest .
```

### Configuration for Cluster
```
cat conf/nifi.properties

nifi.cluster.is.node=true
nifi.cluster.node.address=nifi-node-hostname

nifi.web.http.host=nifi-node-hostname
nifi.remote.input.host=nifi-node-hostname

nifi.zookeeper.connect.string=zookeeper-0:2181,zookeeper-1:2181,zookeeper-2:2181
```

```
cat conf/state-management.xml
...
    <cluster-provider>
        <id>zk-provider</id>
        <property name="Connect String">zookeeper-0:2181,zookeeper-1:2181,zookeeper-2:2181</property>
...

```