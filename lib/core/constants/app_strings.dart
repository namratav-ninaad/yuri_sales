class AppStringsConstants {
  //APP name
  static const String appName = 'Yuri Sales';

  // Api Base URL
  static const String baseUrl = 'http://194.233.64.122:8080/api/';
  static const String loginURl = 'auth/login';
  static const String forgotPasswordURl = 'auth/forgot-password';
  static const String verifyOtpURl = 'auth/verify-otp';
  static const String newPasswordURl = 'auth/new-password';
  static const String changePasswordURl = 'profile/password';
  static const String getProfileURl = 'profile';
  static const String productsURl = 'products';
  static const String updateProfileURl = 'profile/update';
  static const String logoutURl = 'auth/logout';
  static const String addCartURl = 'cart/add';
  static const String customersURl = 'contact/list';
  static const String ordersURl = 'orders';
  static const String invoicesURl = 'invoices';
  static const String deliveriesURl = 'contact/deliveries';
  static const String companyURl = 'company';
  static const String countryURl = 'country';
  static const String stateURl = 'state';
  static const String contactTagURl = 'contacttags';
  static const String paymentTermsURl = 'paymentterms';
  static const String createCustomerURl = 'contact/create';
  static const String cartURl = 'cart';
  static const String cartUpdateURl = 'cart/update';
  static const String cartRemoveURl = 'cart/remove';
  static const String submitRfqURl = 'submit-rfq';

  //Date Format
  static const String ddMMMyyyy = 'dd MMM yyyy'; // 28 Jul 2026
  static const String ddMMyyyySlash = 'dd/MM/yyyy'; // 28/07/2026
  static const String ddMMyyyyDash = 'dd-MM-yyyy'; // 28-07-2026
  static const String MMMddyyyy = 'MMM dd, yyyy'; // Jul 28, 2026
  static const String yyyyMMdd = 'yyyy-MM-dd'; // 2026-07-28
  static const String ddMMMyyyyTime =
      'dd MMM yyyy, hh:mm a'; // 28 Jul 2026, 05:28 AM
  static const String ddMMMyyyyHHmm = 'dd MMM yyyy HH:mm'; // 28 Jul 2026 05:28
  static const String fullDate = 'EEEE, dd MMM yyyy'; // Tuesday, 28 Jul 2026
  static const String MMMyyyy = 'MMM yyyy'; // Jul 2026
  static const String time12 = 'hh:mm a'; // 05:28 AM
  static const String time24 = 'HH:mm';

  //font
  static const String fontFamily = 'Poppins';

  //Share
  static const String accessToken = 'access_token';
  static const String sessionId = 'session_id';
  static const String companyId = 'company_id';
  static const String rememberMeKey = "rememberMe";
  static const String rememberEmail = "rememberEmail";
  static const String rememberPassword = "rememberPassword";
  static const String themeModeKey = "theme_mode";

  //Module String
  static const String fullName = 'Full Name';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String rememberMe = 'Remember Me';
  static const String forgotPassword = 'Forgot Password?';
  static const String login = 'Login';
  static const String submit = 'Submit';
  static const String sendOTP = 'Send OTP';
  static const String verifyCode = 'Verify Code';
  static const String resendCode = 'Resend Code';
  static const String google = 'Google';
  static const String facebook = 'Facebook';
  static const String orContinueWith = 'Or continue with';
  static const String doNotAccount = "Don't have an account?";
  static const String signUp = 'Sign up';
  static const String welcomeBack = 'Welcome Back!';
  static const String forgotPasswordTitle = 'Forget Password';
  static const String otpVerificationTitle = 'Code Verification';
  static const String newCredentials = 'New Credentials';
  static const String loginContinueAccount = 'Login to Continue Your Account';
  static const String forgotPasswordDescription =
      'Provide the email address linked with your account to reset your password';
  static const String email = 'Email';
  static const String otpDescription = 'Enter OTP (One time password) sent to';
  static const String phoneNumber = 'Phone Number';
  static const String min8Characters = 'Min. 8 characters';
  static const String atoZUpperCharacters = '1 uppercase letter (A–Z)';
  static const String aTozLowerCharacters = '1 lowercase letter (a–z)';
  static const String specialCharacters = '1 number or special character';
  static const String welcomeBackUser = 'Welcome back, John 👋';
  static const String businessDescription =
      "Here's what's happening with your business.";
  static const String totalProductSold = 'Total Product Sold';
  static const String revenueGenerated = 'Revenue Generated';
  static const String pendingPayment = 'Pending Payment';
  static const String conversionRatio = 'Conversion Ratio';
  static const String monthlyTarget = 'Monthly Target';
  static const String averageOrderValue = 'Average Order Value';
  static const String achievement = 'Achievement %';
  static const String viewAll = 'View All';
  static const String top10Customer = 'Top 10 Customers';
  static const String top10Product = 'Top 10 Product Sold';
  static const String sold = 'Sold';
  static const String moneyIcon = '₹';
  static const String loginMsg = 'Login Successful!';
  static const String otpSentMsg = 'OTP Sent Successfully!';
  static const String otpVerifiedMsg = 'OTP Verified Successfully!';
  static const String passwordResetMsg = 'Password Reset Successfully!';
  static const String browseProduct = 'Browse Products';
  static const String searchProduct = 'Search products....';
  static const String addToCart = 'Add to cart';
  static const String goToCart = 'Go to Cart';
  static const String searchCustomer = 'Search customer....';
  static const String searchOrder = 'Search order....';
  static const String searchDelivery = 'Search Delivery....';
  static const String searchInvoice = 'Search invoice....';
  static const String createCustomer = 'Create Customer';
  static const String customerName = 'Customer Name';
  static const String companyName = 'Company Name';
  static const String contactPerson = 'Contact Person';
  static const String mobileNumber = 'Mobile Number';
  static const String vatName = 'VAT / TRN';
  static const String paymentTerms = 'Payment Terms';
  static const String creditLimit = 'Credit Limit';
  static const String address = 'Address';
  static const String billingAddress = 'Billing Address';
  static const String shippingAddress = 'Shipping Address';
  static const String gpsLocation = 'GPS Location';
  static const String location = 'Location';
  static const String city = 'City';
  static const String zip = 'Zip';
  static const String attachments = 'Attachments';
  static const String tradeLicense = 'Trade License';
  static const String visitingCard = 'Visiting Card';
  static const String photos = 'Photos';
  static const String tag = 'Tag';
  static const String save = 'Save';
  static const String archive = 'Archive';
  static const String addNewTag = 'Add New Tag';
  static const String addTag = 'Add Tag';
  static const String cancel = 'cancel';
  static const String tagName = 'Tag Name';
  static const String browseFiles = 'Browse Files';
  static const String takePhoto = 'Take Photo';
  static const String add = 'Add';
  static const String customerDetail = 'Customer Detail';
  static const String deliveryDetail = 'Delivery Detail';
  static const String quotations = 'Quotations';
  static const String invoices = 'Invoices';
  static const String salesOrder = 'Sales Order';
  static const String customerStatement = 'Customer Statement';
  static const String deliveryHistory = 'Delivery History';
  static const String notes = 'Notes';
  static const String note = 'Note';
  static const String activities = 'Activities';
  static const String addTagPlus = '+ Add Tag';
  static const String addNotePlus = '+ Add Note';
  static const String editNotePlus = '+ Edit Note';
  static const String text = 'Text';
  static const String voice = 'Voice';
  static const String followUp = 'Follow-up';
  static const String newNote = 'New Note';
  static const String editNote = 'Edit Note';
  static const String tapToRecord = 'Tap to Record';
  static const String recording = 'Recording...';
  static const String recorded = 'Recorded:';
  static const String selectFollowUpDate = 'Select Follow-up Date';
  static const String noDataSelected = 'No date selected';
  static const String saveNote = 'Save Note';
  static const String noteAddSuccessfully = 'Note added successfully!';
  static const String noteErrorMsg = 'Please enter note text';
  static const String voiceNoteMsg = 'Please record a voice note.';
  static const String dateNoteMsg = 'Please select a follow-up date.';
  static const String followUpDate = 'Follow-up Date';
  static const String changePassword = 'Change Password';
  static const String notification = 'Notification';
  static const String language = 'Language';
  static const String theme = 'Theme';
  static const String support = 'Support';
  static const String logout = 'Logout';
  static const String gallery = 'Gallery';
  static const String camera = 'Camera';
  static const String today = 'Today';
  static const String passwordChangeMsg = 'Password changed successfully!';
  static const String changePasswordDescription =
      'For your security, please create a strong password that you don\'t use on other websites.';
  static const String oldPassword = 'Old Password';
  static const String newPassword = 'New Password';
  static const String update = 'Update';
  static const String editProfile = 'Edit Profile';
  static const String profileUpdateMsg = 'Profile updated successfully!';
  static const String logoutAccountMsg =
      'Are you sure you want to logout\nfrom your account?';
  static const String logoutMsg = 'Logout Successful!';
  static const String productCartMsg = 'Product added to cart';
  static const String routeNotFound = 'Route not found';
  static const String createCustomerMsg = 'Create customer successfully!';
  static const String requestQuoteMsg = 'Request Quote successfully!';
  static const String profileDataMsg = 'Profile data not found';
  static const String noCustomerData = 'No Customer Data';
  static const String noOrderData = 'No Order Data';
  static const String noDeliveryData = 'No Delivery Data';
  static const String noInvoiceData = 'No Invoice Data';
  static const String noProductData = 'No Product Data';
  static const String selectCompany = 'Select Company';
  static const String selectCompanyMsg = 'Please select company';

  static const String selectCountry = 'Select country';
  static const String selectCountryMsg = 'Please select country';

  static const String selectState = 'Select state';
  static const String selectStateMsg = 'Please select state';

  static const String selectPaymentTerms = 'Select Payment Terms';
  static const String selectPaymentTermsMsg = 'Please select Payment Terms';
  static const String selectContactTag = 'Select tag';
  static const String selectContactTagMsg = 'Please select tag';
  static const String attachmentAddMsg = 'No attachments added';
  static const String voiceMessage = 'Voice Message';
  static const String myCart = 'My Cart';
  static const String cartEmpty = 'Your cart is empty';
  static const String vat = 'VAT(5%)';
  static const String subtotal = 'Subtotal';
  static const String total = 'Total';
  static const String requestToQuote = 'Request to Quote';
  static const String submitRequest = 'Submit Request';
  static const String qtyUpdateMsg = 'Quantity updated successfully';
  static const String itemRemoveCartMsg = 'Item removed from cart';
  static const String thankYou = 'Thank You!';
  static const String goToHome = 'Go to Home';
  static const String thankYouMsg =
      'Your message has been sent.\nWe will get back to you shortly.';
  static const String chooseTheme = 'Choose Theme';
  static const String light = 'Light';
  static const String dark = 'Dark';
  static const String systemDefault = 'System Default';
  static const String invoiced = 'Invoiced';
  static const String fullInvoiced = 'Fully Invoiced';
  static const String toInvoice = 'To Invoice';
  static const String notInvoiced = 'Not Invoiced';
  static const String invoicedL = 'invoiced';
  static const String fullInvoicedL = 'fully Invoiced';
  static const String toInvoiceL = 'to Invoice';
  static const String no = 'no';
  static const String orderItems = 'Order Items';
  static const String invoiceItems = 'Invoice Items';
  static const String orderSummary = 'Order Summary';
  static const String invoiceSummary = 'Invoice Summary';
  static const String paymentMethod = 'Payment Method';
  static const String invoiceDetail = 'Invoice Detail';
  static const String product = 'Product';
  static const String price = 'Price';
  static const String qty = 'Qty';
  static const String demand = 'Demand';
  static const String unit = 'Unit';
  static const String untaxedAmount = 'Untaxed Amount';
  static const String discount = 'Discount';
  static const String deliveryDate = 'Delivery Name';
  static const String deliveryAddress = 'Delivery Address';
  static const String delivery = 'Delivery';
  static const String confirmed = 'Confirmed';
  static const String formQuotation = 'Form Quotation';
  static const String standardDelivery = 'Standard Delivery';

  static const String waiting = "Waiting";
  static const String ready = "Ready";
  static const String cancelled = "Cancelled";
  static const String done = "Done";

  static const String waitingL = "waiting";
  static const String readyL = "ready";
  static const String cancelledL = "cancelled";
  static const String cancelL = "cancel";
  static const String doneL = "done";

  static const String draft = "Draft";
  static const String notPaid = "Not Paid";
  static const String paid = "Paid";


  static const String notUPaid = "not_paid";
  static const String unpaid = "unpaid";
  static const String draftL = "draft";
  static const String notPaidL = "not paid";
  static const String paidL = "paid";

  //Bottom Navigation
  static const String dashboard = 'Dashboard';
  static const String orders = 'Orders';
  static const String products = 'Products';
  static const String customers = 'Customers';
  static const String profile = 'Profile';

  // Validation Messages
  static const String pleaseEnter = 'Please enter';
  static const String pleaseEnterEmail = 'Please enter email';
  static const String pleaseEnterPassword = 'Please enter password';
  static const String pleaseConfirmPassword = 'Please confirm password';
  static const String invalidEmail = 'Please enter a valid email';
  static const String invalidPhone = 'Please enter a valid phone number';
  static const String passwordMinLength =
      'Password must be at least 6 characters';
  static const String passwordNotMatch = 'Passwords do not match';
  static const String otpErrorMsg = 'Please enter a valid 5-digit OTP';
}
