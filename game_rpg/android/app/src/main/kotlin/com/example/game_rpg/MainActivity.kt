package com.example.game_rpg

import android.os.Bundle
import com.google.android.exoplayer2.util.Log
import com.google.android.exoplayer2.util.Log.*
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.setLogLevel(LOG_LEVEL_OFF)
    }
}
