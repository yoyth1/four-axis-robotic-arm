#include "stm32f10x.h"   // Device header
#include "Delay.h"
#include "OLED.h"
#include "Serial.h"
#include "Key.h"
#include "usart.h"
#include "Servo.h"
#include "Timer.h"
uint8_t KeyNum;
int main(void)
{
	OLED_Init();    //OLED显示屏初始化
	Key_Init();     //按键初始化
	Serial_Init();	//无线串口模块初始化          
    Timer_Init();	//定时器初始化
	Servo_Init();	//舵机模块初始化
	board_init();	//电机通信初始化
	Delay_ms(2000);	//等待去电机驱动初始化完成
	
	while (1)		//显示屏循环显示数据
	{
	 
		OLED_ShowArry(1, Serial_RxPacket, 12); //显示无线串口数据
		OLED_ShowNum(1, 12, KeyNum,4);
		KeyNum+=1;
				
	}
	
	
}





//			OLED_ShowHexNum(4, 1, Serial_TxPacket[0], 2);
//			OLED_ShowHexNum(4, 4, Serial_TxPacket[1], 2);
//			OLED_ShowHexNum(4, 7, Serial_TxPacket[2], 2);

//			OLED_ShowHexNum(1, 1, Serial_RxPacket[0], 2);
//			OLED_ShowHexNum(1, 4, Serial_RxPacket[1], 2);
//			OLED_ShowHexNum(1, 7, Serial_RxPacket[2], 2);
//			OLED_ShowHexNum(1, 1, Serial_RxPacket[3], 2);;
	

     //uint8_t KeyNum;
	//	KeyNum+=1;
















