using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace iljin
{
    //코드 접두어 형식등 상수를 모아둔 클래스
    static public class ConstClass
    {
        public const string CUSTOMER_TYPE_CODE    = "C0001"; //거래처구분
        public const string CUSTOMER_PAY_CODE     = "C0002"; //결제조건
        public const string CUSTOMER_DECIMAL_CODE = "C0003"; //적용소수점                                                   

        public const string ITEM_CODE_PREFIX    = "I";         //제품
        public const string ITEM_DIV1_CODE      = "I0001";     //제품구분1
        public const string ITEM_PET_DIV2_CODE  = "I0002";     //PET - 제품구분2
        public const string ITEM_PP_DIV2_CODE   = "I0003";     //PP - 제품구분2
        public const string ITEM_AL_DIV2_CODE   = "I0004";     //AL - 제품구분2
        public const string ITEM_UNIT_CODE      = "I0005";     //제품단위

        public const string EMP_AUTHORIY_CODE   = "E0001"; //권한
        public const string EMP_DEPARTMENT_CODE = "E0002"; //부서
        public const string EMP_CLASS_CODE      = "E0003"; //직급

        public const string CUTTING_MACHINE_CODE = "CM001"; //제품자르기 작업기계
        public const string WITHDRAWAL_CODE= "WD001"; //입출금 거래유형

        public const string COMPANY_FILE_PATH   = "/CMP/";  //사업장정보 관련파일 저장 위치
        public const string FOREIGNER_FILE_PATH = "/FRGN/"; //외국인관리 관련파일 저장 위치
        public const string PURCHASE_FILE_PATH  = "/PURC/"; //구매계약 문서 파일
        public const string BL_FILE_PATH        = "/BL/";   //BL 원본파일

        public const string CUSTOMER_CODE_PREFIX = "C";     //거래처
        public const string EMP_CODE_PREFIX = "E";     //사원
        public const string ORDER_CODE_PREFIX = "O";     //주문
        public const string TRANSACTION_CODE_PREFIX = "T";     //거래명세서
        public const string TAXBILL_CODE_PREFIX = "TB";     //세금계산서
        public const string REMAKE_CODE_PREFIX = "IR";

        public const string PROGRESS_CODE = "PG001"; // 구매요청등록
    }
}