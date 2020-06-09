package com.example.safety;

import android.os.Bundle; 

import android.content.Intent;
import android.os.Build;
//import android.support.v7.app.AppCompatActivity;
//import android.os.Bundle;

//import io.flutter.embedding.android.FlutterActivity;
import io.flutter.app.FlutterActivity;

//import androidx.annotation.NonNull;

import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private Intent forService;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        startService(new Intent(getBaseContext(), ScanBT.class));		//start ScanBT service
        
        new MethodChannel(getFlutterView(), "com.example.safety")
            .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if(methodCall.method.equals("startService")){
                  startService(new Intent(getBaseContext(), ScanBT.class));
                   // startService();
                    result.success("Service Started");
                }
            }
       });
    
    }

    private void startService(){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
          startForegroundService(forService);
        } else {
          startService(forService);
        }
      }
}
