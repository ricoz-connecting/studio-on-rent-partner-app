import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/controllers/status_controller.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/kyc_verification/controller/kyc_controller.dart';
import 'package:studio_partner_app/src/feature/kyc_verification/views/kyc_verified.dart';
import 'package:studio_partner_app/src/feature/kyc_verification/views/verification.dart';
import 'package:studio_partner_app/src/feature/kyc_verification/views/widgets/kyc_image_builder.dart';
import 'package:studio_partner_app/src/feature/kyc_verification/views/widgets/kyc_status.dart';

class KYCscreen extends ConsumerStatefulWidget {
  const KYCscreen({super.key});

  @override
  ConsumerState<KYCscreen> createState() => _KYCscreenState();
}

class _KYCscreenState extends ConsumerState<KYCscreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final kyc = ref.read(kycControllerProvider);
    _documentController.text = kyc.documentNumber ?? "";
    _nameController.text = kyc.nameOnDocument ?? "";
    
  }

  @override
  void dispose() {
    _nameController.dispose();
    _documentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kyc = ref.watch(kycControllerProvider);
    final status = ref.watch(statusProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'KYC',
          style: GoogleFonts.lato(),
        ),
      ),
      body: status?.kycStatus == "Pending"
          ? const Verification()
          : status?.kycStatus == "Success"
              ? const KycVerified()
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload documents for verification',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.article_outlined,
                                      color: Colors.black),
                                ),
                                hint: const Text('Select document'),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'ID', child: Text('ID')),
                                  DropdownMenuItem(
                                      value: 'Passport',
                                      child: Text('Passport')),
                                  DropdownMenuItem(
                                      value: 'License', child: Text('License')),
                                ],
                                onChanged: (value) {
                                  ref
                                      .read(kycControllerProvider.notifier)
                                      .updateKyc(type: value);
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _documentController,
                              onChanged: (value) {
                                ref
                                    .read(kycControllerProvider.notifier)
                                    .updateKyc(
                                      number: value,
                                    );
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.confirmation_number_outlined,
                                    color: Colors.black),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 14),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Document No.',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _nameController,
                              onChanged: (value) {
                                ref
                                    .read(kycControllerProvider.notifier)
                                    .updateKyc(name: value);
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_outline,
                                    color: Colors.black),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 14),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Enter Name As Per Document.',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Upload Documents',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Consumer(builder: (context, ref, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          ref
                                              .read(kycControllerProvider
                                                  .notifier)
                                              .selectFile('front');
                                        },
                                        child: KYCImageBuilder(
                                          src: null,
                                          file: kyc.frontFile,
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          icon: Icons
                                              .add_photo_alternate_outlined,
                                        ),
                                      ),
                                      Text(
                                        'Front',
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          ref
                                              .read(kycControllerProvider
                                                  .notifier)
                                              .selectFile('back');
                                        },
                                        child: KYCImageBuilder(
                                          src: null,
                                          file: kyc.backFile,
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          icon: Icons
                                              .add_photo_alternate_outlined,
                                        ),
                                      ),
                                      Text(
                                        'Back',
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Consumer(builder: (context, ref, child) {
                        return ReusableButton(
                          onPressed: () {
                            ref
                                .read(kycControllerProvider.notifier)
                                .uploadKyc(context: context);
                          },
                          label: 'Submit',
                        );
                      }),
                    ),
                  ],
                ),
    );
  }
}
