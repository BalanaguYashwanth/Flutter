package com.example.sp1app



import android.annotation.SuppressLint
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    private val CHANNEL = "bluetooth.channel"
    var deviceList: MutableList<BluetoothDevice>? = null;

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {

        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            when (call.method) {
                "getBlue" -> bluetoothWrapper(result)
                "discoverBlue" -> discoverDevices(deviceList, result)
                "allPaired" -> getConnectedDevices(result)
            }
        }
    }

    private fun getConnectedDevices(result: MethodChannel.Result) {
        val mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        val pairedDevices = mBluetoothAdapter.bondedDevices

        val s: MutableList<String> = ArrayList()
        for (bt in pairedDevices) s.add(bt.name)
        result.success(s);
    }

    private fun bluetoothWrapper(result: MethodChannel.Result) {
        val defaultAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
        checkAdapter(result, defaultAdapter);
        enableAdapter(defaultAdapter!!);
    }


    private fun checkAdapter(result: MethodChannel.Result, defaultAdapter: BluetoothAdapter?) {   // check if adapter exists
        if (defaultAdapter == null) {
            result.error("Bluetooth adapter doesn't exist on this device", null, null)
        } else {
            result.success("bluetooth adapter exists on device")
        }


    }

    // check if adapter is enabled if it exists, enable it if it isnt

    @SuppressLint("MissingPermission")
    private fun enableAdapter(bluetoothAdapter: BluetoothAdapter) {
        val requestEnableBt = 1;
        if (!bluetoothAdapter.isEnabled) {
            val enableIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            startActivityForResult(enableIntent, requestEnableBt)
        }
    }

    // register broadcast receiver in order to discover available devices
    private fun discoverDevices(deviceList: MutableList<BluetoothDevice>?, result: MethodChannel.Result) {

        val myAdapter = BluetoothAdapter.getDefaultAdapter();
        myAdapter.startDiscovery();

        val filter = IntentFilter(BluetoothDevice.ACTION_FOUND)
        val receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                when (intent.action) {
                    BluetoothDevice.ACTION_FOUND -> {
                        val device: BluetoothDevice = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE)
                        deviceList?.add(device)
                        println("device found has selected parameters inside the broadcast receivver function $device")
                    }
                    BluetoothAdapter.ACTION_DISCOVERY_FINISHED -> {
                        result.success(deviceList)
                    }
                    "" -> println("broadcast receiver intent.action has no attribute")
                    null -> println("broadcast receiver intent.action was null")
                }
            }
        }
        registerReceiver(receiver, filter)
    }



}