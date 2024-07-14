import 'package:flutter/material.dart';
import '../../../core/shared/theming/text_style.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('سياسة الخصوصية',style: TextStyles.font16mainColorBold,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text('الحالة والحضور',style: TextStyles.font18BlackBold),
            SizedBox(
              height: 10,
            ),
            Text('ولكن هنا أيضا مع الألم.'
                ' حلو مرة، خشن قليلا، قريب من '
                'البعيد، ثابت، مربع الشكل.'
                ' ولكن بالتأكيد أكثر خطورة.'
                ' لذلك ليس هناك عيد ميلاد لأحد.'
                ' بولس، عندما كان يأسر ملك الفرس،'
                ' هل تم نقله على نفس النهر؟ لماذا'
                ' يجب أن نرى، ما إذا كان عقل الفلاسفة'
                ' يمكن أن يعطينا هذا. لكن تخيل ليس'
                ' فقط رجلاً ذكيًا يفعل شيئًا غير أمين،'
                ' بل أيضًا رجلًا وقحًا، مثل م. الآن هناك'
                ' واجب تم القيام به بطريقة يمكن'
                ' من خلالها تقديم سبب محتمل لفعله.',style: TextStyles.font14BlackBold),
            SizedBox(
              height: 80,
            ),
            Text('الشروط والاستخدام',style: TextStyles.font18BlackBold),
            SizedBox(
              height: 10,
            ),
            Text('حتى لا يكون هناك أمثال أصدق من عقائدكم. ومع ذلك، دعونا نحيد'
                ' عن الهدف، ودون مزيد من اللغط، أقول تمامًا،'
                ' بيزو، إذا كانت هذه الأشياء سيئة، يسعدني.'
                ' للجميع حركة ممتعة، ابتهجت بها الحواس. وعندما'
                ' يتجنبون ذلك فإنهم يدافعون عن كلام المشائين.'
                ' أي ماضي؟ ويقول إن هذه الأمور مهمة حتى الآن؛'
                ' إذا قلت ذلك، فقد انتصرنا. ومن يتأثر بهذه '
                'الطريقة، لن يكون سعيدًا أبدًا؛ لذلك لا يتبارك'
                ' أحد من الجهال ولا يتبارك الحكيم. سأقول، أقول، من '
                'أجل التعلم وليس من أجل أن ألومك أو أبيقور.'
                ' ولذلك فإن الألم، وهو الشر الأعظم، '
                'يجب أن نخاف منه دائمًا، حتى لو لم يكن موجودًا.',style: TextStyles.font14BlackBold),
          ],
        ),
      ),
    );
  }
}
