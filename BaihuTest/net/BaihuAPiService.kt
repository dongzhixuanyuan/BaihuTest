package mobi.baihu.api

import io.reactivex.Observable
import mobi.baihu.domain.AlbumCountResponse
import mobi.baihu.domain.AlbumDetailBean
import mobi.baihu.domain.AppVersion
import mobi.baihu.domain.AskAwardResponse
import mobi.baihu.domain.CategoryBean
import mobi.baihu.domain.CommonPictureBean
import mobi.baihu.domain.GirlModelResponse
import mobi.baihu.domain.PostResponse
import mobi.baihu.domain.TagsResponse
import mobi.baihu.pages.favourite.FavouriteBeanOperationReponse
import mobi.baihu.pages.favourite.FavouriteResponse
import mobi.baihu.userInfo.ConfigBean
import mobi.baihu.userInfo.InitAccountReponse
import mobi.baihu.userInfo.LoginBindChangeResponse
import mobi.baihu.userInfo.ResetAccountReponse
import mobi.baihu.userInfo.SignInResponse
import mobi.baihu.userInfo.SignRecordResponse
import mobi.baihu.userInfo.UserInfoResponse
import mobi.baihu.userInfo.VerifyCodeResponse
import retrofit2.http.DELETE
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path
import retrofit2.http.Query



api.url=http://129.211.27.144:8080
mta.app_key=A3I9DWJ51JVX

interface BaihuAPiService {

    /**************相册相关*************/

    //首页类别
    @GET("/mobile/category")
    fun getCategories(): Observable<CategoryBean>

    @GET("/mobile/album/all")
    fun findAllByNewest(@Query("page") page: Int, @Query("size") size: Int): Observable<CommonPictureBean>

    @GET("/mobile/album/recommend")
    fun findAllByRecommend(/*@Query("page") page: Int,*/ @Query("size") size: Int): Observable<CommonPictureBean>

    @GET("/mobile/album/free_limits")
    fun findAllByFreeLimits(): Observable<CommonPictureBean>

    @GET("/mobile/album/all_by_category")
    fun findAllByCategory(
        @Query("category_id") category_id: String, @Query("page") page: Int, @Query(
            "size"
        ) size: Int
    ): Observable<CommonPictureBean>

    @GET("/mobile/album/tops")
    fun findTopAlbums(@Query("page") page: Int, @Query("size") size: Int): Observable<CommonPictureBean>


    @GET("/mobile/model/recommends")
    fun getRecommendModels(@Query("quantity") count: Int): Observable<GirlModelResponse>

    @GET("/mobile/model")
    fun getAllModel(): Observable<GirlModelResponse>

    @GET("/mobile/album/all_by_model")
    fun queryByModel(@Query("model_id") modelId: String, @Query("page") page: Int, @Query("size") size: Int): Observable<CommonPictureBean>

    @GET("/mobile/tag")
    fun getAllTags(): Observable<TagsResponse>

    @GET("/mobile/tag/recommends")
    fun getRecommendTags(@Query("quantity") count: Int): Observable<TagsResponse>

    @GET("/mobile/album/all_by_tag")
    fun queryByTag(@Query("page") page: Int, @Query("size") size: Int, @Query("tag_id") tagId: String): Observable<CommonPictureBean>

    @GET("/mobile/album/{id}")
    fun getAlbumDetail(@Path("id") id: String):Observable<AlbumDetailBean>
    
    @GET("/mobile/album/count_by_model")
    fun getModelAlbums(@Query("model_id") model_id:String):Observable<AlbumCountResponse>

    @GET("/mobile/album/count_by_tag")
    fun getTagAlbums(@Query("tag_id") tagID:String):Observable<AlbumCountResponse>
    /**************相册相关*************/


    @GET("/mobile/app_version/check")
    fun checkAppVersion(): Observable<AppVersion>


    /**************账号相关*************/

    //第一次打开app初始化账号
    @POST("/mobile/auth/initialize")
    fun initialAccount(): Observable<InitAccountReponse>

    //获取用户信息
    @GET("/mobile/auth/current_user")
    fun getUserInfo(): Observable<UserInfoResponse>

    @FormUrlEncoded
    @POST("/mobile/auth/fetch_auth_code")
    fun getVarifyCode(@Field("phone_number") phoneNumber: String): Observable<VerifyCodeResponse>

    //登录or绑定or切换账号
    @FormUrlEncoded
    @POST("/mobile/auth/login")
    fun loginBindChangeAccount(@Field("code") code: String, @Field("key") key: String): Observable<LoginBindChangeResponse>

    //    重置绑定
    @POST("/mobile/auth/reset_binding")
    fun resetBind(): Observable<ResetAccountReponse>

    /**************账号相关*************/

    /*******start******奖励相关*************/
    @FormUrlEncoded
    @POST("/mobile/award/publish")
    fun askForAward(@Field("quantity") quantity: Int, @Field("reason") reason: String, @Field("type") type: AWARDTYPE): Observable<AskAwardResponse>

    @FormUrlEncoded
    @POST("/mobile/vip/translate")
    fun exchangeEnergyForVip(@Field("days") days: Int): Observable<AskAwardResponse>

    @GET("/mobile/config")
    fun getConfig(): Observable<ConfigBean>
    /*******end*******奖励相关*************/


    /*******start*******收藏相关*************/
    @GET("/mobile/favorite")
    fun getAllFavourite():Observable<FavouriteResponse>

    @FormUrlEncoded
    @POST("/mobile/favorite")
    fun addFavourite(@Field("album_id") album_id: String):Observable<FavouriteBeanOperationReponse>

    @DELETE("/mobile/favorite/{id}")
    fun deleteFavourite(@Path("id") id: String):Observable<PostResponse>

    @GET("/mobile/favorite/check_exists")
    fun checkHasFavourited(@Field("album_id") album_id: String)

    @GET("/mobile/album/visit")
    fun getAlbumScanHistory(@Query("page") page: Int, @Query("size") size: Int):Observable<FavouriteResponse>

    @POST("/mobile/album/visit/{id}")
    fun reportVisitAlbum(@Path("id") album_id: String):Observable<PostResponse>

    /*******end*******收藏相关*************/

    @GET("/mobile/user/last_sign_in")
    fun getLastSignRecord(): Observable<SignRecordResponse>

    @POST("/mobile/user/sign_in")
    fun signIn(): Observable<SignInResponse>

}

enum class AWARDTYPE {
    VIP, INTEGRAL;

    override fun toString(): String {
        return super.toString()
    }
}
