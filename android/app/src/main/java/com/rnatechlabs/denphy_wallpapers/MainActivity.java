package com.rnatechlabs.denphy_wallpapers;

import android.os.Bundle;

import androidx.annotation.RequiresApi;
//import androidx.appcompat.app.AppCompatActivity;

import android.Manifest;
import android.app.WallpaperManager;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.File;
import java.io.IOException;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

public class MainActivity extends FlutterActivity {
    private static final String TAG = "MainActivity";
    private static final String CHANNEL = "samples.flutter.dev/battery";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        String path = call.argument("path");
                        int type = call.argument("type");
                        android.util.Log.e(TAG, "onMethodCall: >>>>>>>" + path);
                        android.util.Log.e(TAG, "onMethodCall: >>>>"+ type);
                        if (call.method.equals("setWallpaper")) {
                            int setWallpaper = setWallpaper(path,type);
                            if (setWallpaper == 0) {
                                result.success(setWallpaper);
                            } else {
                                result.error("UNAVAILABLE", "", null);
                            }
                        } else {
                            result.notImplemented();
                        }
                    }
                }
        );

    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        return batteryLevel;
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    private int setWallpaper(String path, int wallpaperType) {
        int setWallpaper = 1;
        Bitmap bitmap = BitmapFactory.decodeFile(path);
        WallpaperManager wallpaperManager = WallpaperManager.getInstance(getApplicationContext());
        try {
            wallpaperManager.setBitmap(bitmap, null, true, wallpaperType);
            setWallpaper = 0;
        } catch (Exception e) {
            setWallpaper = 1;
        }
        return setWallpaper;
    }
}
