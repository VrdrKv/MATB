function send_comm(Value)       
global MATB_DATA
MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber},cat(2,3,Value));

