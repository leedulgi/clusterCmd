# clusterCommand
여러 서버에 명령을 내릴 수 있게 제작
* ssh 매핑이 되어 있어야 함 (키 교환 권장)
* 원격 서버에서 sudo 명령이 필요한 경우를 위해 sudoers 에 해당 계정 NOPASSWD 추가

# config
clcmd.conf 파일을 편집
```
# nodes=사용할 노드의 ssh host명 입력
nodes=node1 node2 node3 node4
# curNode=nodes 목록중 현재 접속한 서버의 노드
curNode=node1
```

# 사용
```
**SYNOPSIS**
  clcmd __sub_command__ __argument__
  
**OPTIONS**
  -c  다른 노드에서 사용할 명령
      clcmd -c **command**
      ex) clcmd -c chmod u+w ~/testfile 
  
  -s  모든 노드에 파일 복사
      clcmd -s **org_file** **destination_path**
      ex 1) clcmd -s testFile ~
      ex 2) clcmd -s testFile
      ex 3) clcmd -s /home/yura/testDir/testFile /home/dulgi  
  -a  특정 파일의 내용을 다른 노드들의 파일에 추가
      clcmd -a **append_file
      ex) clcmd -a ~/testFile ~/testDir/targetFile
```




2022.01.20 proto
