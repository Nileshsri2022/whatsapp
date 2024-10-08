import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/widgets/error.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/select_contacts/controller/select_contact_controller.dart';

final selectedGroupContacts = StateProvider<List<Contact>>((ref)=>[]);

class SelectContactsGroup extends ConsumerStatefulWidget {
  const SelectContactsGroup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectContactsGroupState();
}

class _SelectContactsGroupState extends ConsumerState<SelectContactsGroup> {
  List<int> selectedContactsIndex = [];
  void selectContact(int index, Contact contact) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.removeAt(index);
    } else {
      selectedContactsIndex.add(index);
    }
    setState(() {});
    ref.read(selectedGroupContacts.notifier).update((state)=>[...state,contact]);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getContactsProvider).when(
        data: (contactList) => Expanded(
              child: ListView.builder(
                  itemCount: contactList.length,
                  itemBuilder: (context, index) {
                    final contact = contactList[index];
                    // to make clickable through leading property
                    return InkWell(
                      onTap: () => selectContact(index, contact),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            contact.displayName,
                            style: TextStyle(fontSize: 18),
                          ),
                          leading: selectedContactsIndex.contains(index)
                              ? IconButton(
                                  onPressed: () {}, icon: Icon(Icons.done))
                              : null,
                        ),
                      ),
                    );
                  }),
            ),
        error: (err, trace) => ErrorScreen(error: err.toString()),
        loading: () => Loader());
  }
}
