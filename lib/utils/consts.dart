import 'package:flutter_dotenv/flutter_dotenv.dart';

final Uri url = Uri.parse("https://${dotenv.env["URL"]!}");
