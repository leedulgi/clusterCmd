# cluster tools
여러 서버에 명령을 내릴 수 있게 제작
* ssh config 파일 필요
* 원격 서버에서 sudo 명령이 필요한 경우를 위해 sudoers 에 해당 계정 NOPASSWD 추가

# config
cluster-tools.conf 파일을 편집
* target_nodes : 사용할 노드의 ssh host명 입력
target_nodes=node1 node2 node3 node4
* curNode : 목록중 현재 접속한 서버의 노드
curNode=node1
like ssh, command without quotes not be garanteed

# usage
**usage**
  cltls [__sub_command__] [__argument__] [__option__] [__command__]
  ex) cltls chmod u+w ~/testfile

**subcommand**
   - cp    cp to other nodes
      cltls cp **org_file** **destination_path**
      ex 1) cltls -s testFile ~
      ex 2) cltls -s testFile
      ex 3) cltls -s /home/yura/testDir/testFile /home/dulgi  
   - sync  rsync for all other nodes
      cltls sync .
   - apnd  특정 파일의 내용을 다른 노드들의 파일에 추가
      cltls apnd append_source target
      ex) cltls -a ~/testFile ~/testDir/targetFile


# requires
* 스레드처리(pthread)
* \* 지원 (와일드카드)
* cp 디렉토리 자동 생성 
* getopts
* specify a node


