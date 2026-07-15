pipeline {
	agent any

	parameters {
		string(name: 'MAJOR', defaultValue: params.MAJOR ?:'1', description: 'Major version')
		string(name: 'MINOR', defaultValue: params.MINOR ?:'0', description: 'Minor version')
	}

	triggers {
		pollSCM('H/5 * * * *')
	}

	stages {
		stage('Prepare') {
			steps {
				sh 'make prepare'
			}
		}

		stage('Configure') {
			steps {
				sh 'MAJOR=$MAJOR MINOR=$MINOR make config'
			}
		}

		stage('Clean') {
			steps {
				sh 'make clean'
			}
		}
		
		stage('Build') {
			steps {
				sh 'MAJOR=$MAJOR MINOR=$MINOR BUILD_NUMBER=$BUILD_NUMBER make build_in_docker'
			}
		}
	}

	post {
		success {
			dir("openwrt/bin/targets/zixlink-zl90/") {
				archive ("openwrt-zixlink-zl90*")
			}
		}
	}
}
