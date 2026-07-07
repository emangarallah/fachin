
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../core/colors.dart';
import 'custom_text.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    required this.image,
    required this.name,
    required this.descp,
    required this.price,
    required this.onChanged,
    required this.qty,
  });

  final String image, name, descp;
  final int price;
  final Function(int) onChanged;
  final int qty;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late int number;

  @override
  void initState() {
    number = widget.qty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. عرض صورة المنتج بحجم ثابت (120 بكسل)
        Image.asset(
          widget.image,
          width: 80,
          height: 80,
          fit: BoxFit.cover,

        ),
        const Gap(20),

        // 2. استخدام Expanded هنا يجبر العمود والنصوص على أخذ المساحة المتبقية فقط ومنع الخطأ
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomText(
                text: widget.name.toUpperCase(),
                spacing: 4,
                color: AppColors.primary,
              ),
              const Gap(10),

              // تم حذف الـ SizedBox وحسابات العرض اليدوية لتلتف النصوص تلقائياً بأمان
              CustomText(
                text: widget.descp.toUpperCase(),
                spacing: 2,
                color: AppColors.primary,
                size: 11,
              ),
              const Gap(30),

              // أزرار التحكم في الكمية
              Row(
                children: [
                  qty(() {
                    setState(() {
                      if (number > 1) {
                        number--;
                        widget.onChanged(number);
                      }
                    });
                  }, "assets/svgs/min.svg"),

                  const Gap(12),

                  CustomText(
                    text: number.toString(),
                    spacing: 4,
                    color: AppColors.primary,
                    weight: FontWeight.bold,
                  ),

                  const Gap(12),

                  qty(() {
                    setState(() {
                      number++;
                      widget.onChanged(number);
                    });
                  }, "assets/svgs/plus.svg"),
                ],
              ),
              const Gap(28),

              // سعر المنتج
              CustomText(
                text: "\$ ${widget.price}",
                color: Colors.red.shade200,
                size: 22,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// الوجت الخاص بأزرار الزيادة والنقصان (+) و (-)

Widget qty(VoidCallback onTap, String svg) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(6), // تم زيادة الحشو قليلاً لتسهيل الضغط بالإصبع
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: SvgPicture.asset(
        svg,
        width: 16,  // تحديد أبعاد الـ SVG يحميه من التمدد خارج الدائرة
        height: 16,
        // ملحوظة: إذا كنت تريد تغيير لون الأيقونة برمجياً يمكنك إضافة colorFilter هنا
      ),
    ),
  );
}