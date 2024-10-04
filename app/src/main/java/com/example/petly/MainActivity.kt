package com.example.petly

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.example.petly.ui.theme.PetlyTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 1초 딜레이 후 메인 화면으로 전환
        Handler(Looper.getMainLooper()).postDelayed({
            // MainScreenActivity로 넘어가기
            val intent = Intent(this, MainScreenActivity::class.java)
            startActivity(intent)
            finish() // Splash 화면을 끝내기
        }, 1000) // 1000ms = 1초

        enableEdgeToEdge()
        setContent {
            PetlyTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Greeting(
                        name = "Android",
                        modifier = Modifier.padding(innerPadding)
                    )
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    PetlyTheme {
        Greeting("Android")
    }
}