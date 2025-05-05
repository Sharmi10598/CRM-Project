part of '../home_page.dart';

class _BuildScrollableList extends StatelessWidget {
  final List<NotesData>? notes;

  const _BuildScrollableList({Key? key, this.notes}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var length=0;
    if(notes!.length==1){
        length = 1;
     } 
      else if(notes!.length==2){
        length = 2;
     } 
      else if(notes!.length>=3){
        length = 3;
     }
     if(length>0){
    final theme = Theme.of(context);
    return
     SizedBox(
      width: Screens.width(context),
      height: Screens.heigth(context) * 0.15,
      child: 
      ListView.builder(
        itemCount: length,
        padding: const EdgeInsets.only(left: Const.margin, right: Const.margin),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
       return InkWell(
         onTap: (){
             NotesDetailsState.heading = notes![i].MsgHeading;
                      NotesDetailsState.description = notes![i].MsgDescription;
                        Get.toNamed<dynamic>(FurneyRoutes.notesDetails);
         },
         child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: Screens.heigth(context) * 0.01,
                    horizontal: Screens.width(context) * 0.02,),
                child: Column(children: [
                  SizedBox(
                    width: Screens.width(context) * 0.3,
                    child: Text(
                      '${notes![i].MsgHeading}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.boldPC1(context),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  SizedBox(
                    width: Screens.width(context) * 0.3,
                    child: Text('${notes![i].MsgDescription}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.bodytextBlack1(context),),
                  ),
                ],),
              ),
            ),
       );
        },
     ),
    );
     }
return const SizedBox();
  }
}
