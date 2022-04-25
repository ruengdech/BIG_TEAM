/*
 
 งานค้างวันที่ 2021-06-27 
 ส่วนของ Sale Funnel คือหน้าให้กดเพื่อขออนมัติยังค้าง บรรทัด 


sys02.list_approve.js
บรรทัด 476 

if (JOB_DATA[i][41].length > 2) {
                TMP_ROW = TMP_ROW + "<td><a href = 'http://saintmed.dyndns.biz:10898/view_req.php?ID=" + JOB_DATA[i][40] + "&PID=" + JOB_DATA[i][41] + "' target='_blank'>อนุมัติโครงการ</a><br />REQ NO. " + JOB_DATA[i][40] + "<br />PROJECT ID " + JOB_DATA[i][41] + "</td>";
            } else if (JOB_DATA[i][40].length > 2) {
                TMP_ROW = TMP_ROW + "<td><a href = 'http://saintmed.dyndns.biz:10898/view_req.php?ID=" + JOB_DATA[i][40] + "&PID=' target='_blank'>รออนุมัติ</a><br />REQ NO. " + JOB_DATA[i][40] + "</td>";
            } else {
                TMP_ROW = TMP_ROW + "<td>คลิกเพื่อขออนุมัติ</td>";
            }

รอให้กดบันทึกแล้วงานเข้า

From MAN 2021-06-29
table : projects_pre
- เบื้องต้น insert ข้อมูลชุดเดิมเข้ามาที่ field ชื่อเดิมได้เลยครับ
 - ส่งข้อมูล funnel_id เพิ่มเติมเข้า field คือ funnel_id ครับ

 */



/*
 2021-08-02 ระบบติดตั้ง
 หน้า Admin รอ Assign ปรับเปลี่ยนรูปแบบให้แสดงผลตามวันที่ต้องการให้งานแล้วเสร็จ [แก้ไขแล้วปรับเพิ่ม Column ให้มีวันที่ขอให้ติดตั้งและเรียงลำดับแล้ว]
 ปรับปรุงระบบแจ้งเตือนผ่าน Email [แก้ไขหัวข้อ ของ Email แล้ว]
 ปรับปรุงส่วนของโครงสร้างเมนูทำรายการของ Admin, ช่าง [ปรับแก้เมนูแล้ว]
 ปรับปรุงส่วนแสดงผลให้เห็นชื่อช่างเพื่อ Filter งานได้ [เพิ่ม แสดง Column แล้วพร้อม Filter ได้]
 ปรับเปลี่ยน Flow การทำงานให้เปลี่ยนช่างได้เมื่อมีการ assign งานไปแล้ว     [assigned, plan, start] 3 สถานะนี้ให้เลือกกลับมา Assign ใหม่ได้ โดยเลือกจาก งานทั้งหมดนะครับ
 ทำการ Sync ข้อมูลทั้งหมดของระบบผ่าน Excel ให้ทีม Admin [เสร็จแล้ว]


 เพิ่มระบบประเมินงานช่าง โดยลูกค้าเพื่อสนับสนุนแนวทางของ Interal Audit [ช่างกดบันทึกงานปิด จะส่ง SMS ประเมินอัตโนมัติ, Admin มีปุ่มให้กดส่ง SMS ถ้ายังไม่ได้รับการประเมิน]
 เพิ่มระบบรายงานวิเคราะห์ผลประเมินจากลูกค้า (https://saintmed.dyndns.biz/net/sys04/admin_s.aspx)
- เพิ่มระบบ Dashboard เพื่อดู Performance ของทีมงานช่าง

ประสานงาน Vender เพื่อเปิดใช้บริการ SMS Gateway รองรับระบบประเมิน และ Marketing ในอนาคต [Done]
ประสานงาน Vender เพื่อ Custom API สำหรับ Saintmed [Done]



*** งานค้างในเชิง Concept ต้องทำหน้าดูรายการ ประเมิน
 * ส่วนของ admin_s.aspx
 * บรรทัด 190 หลังจากเพิ่มข้อมูลเข้าไปใน ARRAY
 */


// 2022-01-11 งานค้างที่ รับค่ามาหลังจากท่่บันทึกสำเร็จจะทำอะไร ทำต่อที่ไฟล์ reg_customer.js Line 134
// 2022-01-13 งานค้างที่ ทำ Function Save File ได้แล้ว เหลือ แต่งข้อมูลให้สวย ด้วยการส่ง LINE ID ไป นะครับ  Admin.aspx LINE 183