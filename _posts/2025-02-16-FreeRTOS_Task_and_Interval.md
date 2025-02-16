---
layout: post
title: "FreeRTOS Task and Interval"
date: 2025-02-16 22:31:11 +0900
categories:
---

## FreeRTOS
[FreeRTOS](https://github.com/freertos) is an open source real time operating system that can be used on many microcontrollers including RA6M3 that I used for a project. It can meet the hard-real time requirements where unabling to run a specific task before a deadline is a system failure. Users can control an interval of the task so that it executes periodically.

## Task
FreeRTOS provides API functions for the **Task**. The task is implemented in C function which acts like the C `main()` with different prototype and additional constraints.


The prototype is defined in [include/projdefs.h](https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/include/projdefs.h)
```
typedef void (*TaskFunction_t)(void*);
```
Function definition should looks like
```
void deserializeEthernetFrame(void* param)
{
    for (;;)
    {
        /* work */
    }
    vTaskDelete(NULL);
}
```
One of the constraints is that a task must be terminated by using `vTaskDelete(NULL)` instead of `return;`. It is necessary because there is no automatic deallocation of kernel resource like general operating systems where a separation between user space and kernel space exists.


### Create
There are many API functions for the creation of the task. They provides options for static memory allocation, resource privilege and affinity on SMP.


`vTaskCreate()` function is the most simple one.
```
BaseType_t xTaskCreate(
    TaskFunction_t pvTaskCode,
    const char* const pcName,
    configSTACK_DEPTH_TYPE usStackDepth,
    void* pvParameters,
    UBaseType_t uxPriority,
    TaskHandle_t* pxCreatedTask);
```
- `pvTaskCode` a function pointer to be executed.
- `pcName` a descriptive string for a task.
- `usStackDepth` is multiplicated by the word size to decide the size of the stack. If the word size is 4 bytes and `usStackDepth` is 128, stack size is 512 bytes.
- `pvParameters` is argument of the pvTaskCode function.
- `uxPriority` defines the task's priority. FreeRTOS uses priority based round robin scheduler.
- `pxCreatedTask` is an address to store a handle or NULL.


### Tick Interval
A task runs for a time slice that is equal to the interval of two consecutive ticks. The interval is compile-time constant and `configTICK_RATE_HZ` macro contains its value. If the value is 1000, tasks will run for 1 millisecond and be preempted by the scheduler.

### Sleep
`vTaskDelay()` function places the calling task into the **Blocked** state for a fixed number of tick interrupts. Users can adjust the interval larger than the tick interval by using this function.
```
void vTaskDelay(TickType_t xTicksToDelay); 
```
Example
```
void deserializeEthernetFrame(void* param)
{
    for (;;)
    {
        /* work */
        vTaskDelay(pdMS_TO_TICKS(10));
    }
    vTaskDelete(NULL);
}
```
`pdMS_TO_TICKS` is function macro which convert milliseconds to ticks. This task will be placed to **Blocked** state for 10 ms after work has been done.

## Reference
[Mastering the FreeRTOS Real Time Kernel v1.1.0](https://www.freertos.org/Documentation/02-Kernel/07-Books-and-manual/01-RTOS_book)
