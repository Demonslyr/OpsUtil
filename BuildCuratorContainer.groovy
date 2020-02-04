node{
def remote = [:]
stage('setup'){
checkout scm
currentBuild.description = "${Branch}"
remote.name = 'ApiHost'
remote.host = 'c-00-master-00'
remote.user = 'dp_jenkins'
remote.allowAnyHosts = true
dockerRepo = "atriarchsystems"
appName = "CuratorContainer"
}
stage('build'){
def buildout = sh(returnStdout: true, script: "docker build -t ${appName} -f ./Dockerfile .")
println buildout
}
    stage('push'){
        def tagout = sh(returnStdout: true, script: "docker tag ${appName} ${dockerRepo}/${appName}:latest")
        println tagout
        withCredentials([usernamePassword(usernameVariable: "DOCKER_USER",passwordVariable: "DOCKER_PASS", credentialsId: dockerCredId)]){
            def loginout = sh(returnStdout: true, script: "echo ${DOCKER_PASS} | docker login --username ${DOCKER_USER} --password-stdin")
            println loginout
            def pushout = sh(returnStdout: true, script: "docker push ${dockerRepo}/${appName}:latest")
            println pushout
        }
    }
    stage('deploy'){
            try {
                sshCommand remote: remote, command: "kubectl get pods"
            } catch(e) {
                echo e.toString()   
            }
    }     
}
