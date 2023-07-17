package com.estore.helper;

public class Dfetcher {
    private String desc;

    public String getMini(String desc){
        String[] strs = desc.split(" ");
        String ret="";
        if (strs.length>10){
            for (int i=0;i<10;i++){
                ret= ret+strs[i]+" ";
            }
            return (ret+".....");
        }else {
            ret=desc;
        }
        return ret;
    }
}
