// public class ScanBT {
    
// }
// public class ScanBT {
    
// }
package com.example.safety;

import android.app.Service;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;
import android.util.Log;
import android.widget.Toast;

import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.UUID;

public class ScanBT extends Service {  
	
    Handler handler = new Handler();
	private boolean mScanning;
	private BluetoothAdapter mBluetoothAdapter;
	private BluetoothManager mBluetoothManager;

	private Runnable runnableCode = new Runnable() {
		@Override
		public void run() {		  
		  if (mScanning) {
			  mScanning = false;
              mBluetoothAdapter.stopLeScan(mLeScanCallback);	// stop bluetooth scan
			  //mBluetoothAdapter.startScan(mLeScanCallback);	// stop bluetooth scan
			  Log.d("ScanBT", "Stop Scanning");
			  handler.postDelayed(runnableCode, 2000);	// Repeat this the same runnable code block again another 2 seconds
		  } else {
			  mScanning = true;
              mBluetoothAdapter.startLeScan(mLeScanCallback);	// start bluetooth scan
			  Log.d("ScanBT", "Start Scanning");
			  handler.postDelayed(runnableCode, 2000);	// Repeat this the same runnable code block again another 2 seconds
		  }
		}
	};
	
	public ScanBT() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
	
	@Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Toast.makeText(this, "ScanBT Started", Toast.LENGTH_LONG).show();
		
		mBluetoothManager = (BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE);		//instantiate the object
		mBluetoothAdapter = mBluetoothManager.getAdapter();
		
		handler.post(runnableCode);	// start the handler runnable
		
		return super.onStartCommand(intent, flags, startId);	
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Toast.makeText(this, "ScanBT Destroyed", Toast.LENGTH_LONG).show();
    }	
	
	private BluetoothAdapter.LeScanCallback mLeScanCallback = new BluetoothAdapter.LeScanCallback() {
		@Override
		public void onLeScan(final BluetoothDevice bluetoothDevice, final int rssi, final byte[] scanData) {
			if (scanData[7] == 0x02 && scanData[8] == 0x15) { // iBeacon indicator
				UUID uuid = getGuidFromByteArray(Arrays.copyOfRange(scanData, 9, 25));
				int major = (scanData[25] & 0xff) * 0x100 + (scanData[26] & 0xff);
				int minor = (scanData[27] & 0xff) * 0x100 + (scanData[28] & 0xff);
				byte txpw = scanData[29];
				Log.i("ScanBT", "iBeacon Major = " + major + " | Minor = " + minor + " TxPw " + (int)txpw + " | UUID = " + uuid.toString());
			}
		}

	};
	
	public static String bytesToHexString(byte[] bytes) {
		StringBuilder buffer = new StringBuilder();
		for(int i=0; i<bytes.length; i++) {
			buffer.append(String.format("%02x", bytes[i]));
		}
		return buffer.toString();
	}
	public static UUID getGuidFromByteArray(byte[] bytes)
	{
		ByteBuffer bb = ByteBuffer.wrap(bytes);
		UUID uuid = new UUID(bb.getLong(), bb.getLong());
		return uuid;
	}
	
	 

}