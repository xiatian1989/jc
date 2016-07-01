package com.rwkj.jc.domain;

public class SystemInfo {
	private String oS;
	private String serverName;
	private String javaHome;
	private String serverInfo;
	private String contextPath;
	private String serverHostIP;
	private String protocol;
	private String serverPort;
	private String serverTime;
	
	public String getoS() {
		return oS;
	}
	public void setoS(String oS) {
		this.oS = oS;
	}
	public String getServerName() {
		return serverName;
	}
	public void setServerName(String serverName) {
		this.serverName = serverName;
	}
	public String getJavaHome() {
		return javaHome;
	}
	public void setJavaHome(String javaHome) {
		this.javaHome = javaHome;
	}
	public String getServerInfo() {
		return serverInfo;
	}
	public void setServerInfo(String serverInfo) {
		this.serverInfo = serverInfo;
	}
	public String getContextPath() {
		return contextPath;
	}
	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}
	public String getServerHostIP() {
		return serverHostIP;
	}
	public void setServerHostIP(String serverHostIP) {
		this.serverHostIP = serverHostIP;
	}
	public String getProtocol() {
		return protocol;
	}
	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}
	public String getServerPort() {
		return serverPort;
	}
	public void setServerPort(String serverPort) {
		this.serverPort = serverPort;
	}
	public String getServerTime() {
		return serverTime;
	}
	public void setServerTime(String serverTime) {
		this.serverTime = serverTime;
	}
}
