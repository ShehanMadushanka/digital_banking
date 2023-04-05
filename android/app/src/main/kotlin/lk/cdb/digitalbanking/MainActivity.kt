package lk.cdb.digitalbanking

import android.os.Bundle
import androidx.annotation.NonNull
import external.JustPayCalls
import external.LankaQRScanner
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import nonsense.AelonFlux
import nonsense.Luca
import nonsense.TerraNova
import nonsense.VisionAXEOM

class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "cdb_secure_method_channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "c8fe82764f3a63f8eb5cd8c11a272b313ef113880c8eb3b8714004719eb958c3" -> {
                    result.success(VisionAXEOM.getMicroFabricationStructure(this))
                }
                "2672ef947486257c71881b970411546803f35a4ed09833edf55ab2e8968684c0" -> {
                    result.success(Luca.getSilicaNucleicAcidExtractionPHValue(this))
                }
                "cdec2bb0ae84adc926bac868fc193b34a8e40a0e2970c9cda11f6bf9124427ef" -> {
                    result.success(AelonFlux.isStaticFluxReleased(this))
                }
                "bcf8b716f48ac74e853995f0a59fbdfe7f261fa247784ba8fe19218a07ce9517" -> {
                    result.success(TerraNova.hasMaxQPassed())
                }
                "D995DA23505A798C93DA3E2E7F2F1611BB3F4DF1110612705F60C17DFD2759FF" -> {
                    val qrString = call.argument<String>("qrString")
                    val lankaQr = LankaQRScanner.getLankaQRData(qrString)
                    if (lankaQr == LankaQRScanner.LQRErrorCode)
                        result.error(LankaQRScanner.LQRErrorCode, LankaQRScanner.InvalidLQR, LankaQRScanner.InvalidLQR)
                    else
                        result.success(lankaQr)
                }

                "e5c04fba45d532efde8556112f7348af05390329006e25d2dfc0be958d96b764" -> {
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    val deviceId = justPay.deviceID
                    if (deviceId == null)
                        result.error(JustPayCalls.ERR_DID, JustPayCalls.ERR_DID, JustPayCalls.ERR_DID)
                    else
                        result.success(deviceId)
                }
                "e9743512bb66c5d4c51d6708900ab41d281e8d2c25418748dbcf90c34871a39e" -> {
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    result.success(justPay.isIdentityExist)
                }
                "e481371a5ccdde8ae32b83f3a1a8f189bb21da39e374b7b9ab6a51fbceaa1c47" -> {
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    result.success(justPay.revoke())
                }
                "b7b56e183578a1ffb909354c3a57679196af73a93da06ace2a6c4597be670fc5" -> {
                    val challenge = call.argument<String>("challenge")
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    justPay.createIdentity(challenge) { payPayload -> result.success(payPayload) }
                }
                "2956c01f62d011b2dd41b33ac66d25a671ba99bb7af77306c9cd9eaf737f44ee" -> {
                    val terms = call.argument<String>("terms")
                    val justPay = JustPayCalls.getInstance(applicationContext)
                    justPay.signMessage(terms) { payPayload -> result.success(payPayload) }
                }
            }
        }
    }

}
