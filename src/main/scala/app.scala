
import scala.collection.immutable.ListMap
import javax.servlet.Filter
import javax.servlet.FilterChain
import javax.servlet.FilterConfig
import javax.servlet.ServletRequest
import javax.servlet.ServletResponse
import javax.servlet.http.{HttpServlet, HttpServletRequest => HSReq, HttpServletResponse => HSResp}

class ShadowInitServlet extends HttpServlet {

  var map = resetMap

  def --(init: Int) = init - 10

  def calculateExtraPasses(init: Int): String =  if ( --(init)  > 0) (" | " + (--(init) + calculateExtraPasses( --(init) ) ) ) else ""

  def resetMap() = Map( ("sean", (21, false )) , ("sim-eon", (18, false)), ("gretchen", (13,false)), ("bakari", (12,false) ) )

  def updateMap(name: String, init: String, isNpc: Boolean) = { map = map.+( (name, (Integer.valueOf(init),isNpc ) ) ) }

  def deleteRow(name: String) = if ( name != null && map.contains(name) ) map = map - name

  def convertNpcValueToBool(isNpc: String) = if ( isNpc == null ) false else true

  def checkPcNameAndInitValue(name: String, init: String) = ( name != null && init != null && ! "".equals(name) && ! "".equals(init) )

  def updateInit(name: String, init: String, isNpc: String) =
    if ( checkPcNameAndInitValue(name, init) )  updateMap(name, init, convertNpcValueToBool(isNpc))

  def updateInitWithArray(arr: Array[String]) = if ( arr.length > 0 ) updateInit( arr(0), arr(1), ( if ( arr.length == 3) arr(2) else null ))

  def updateInitByRest(path: String) = if ( path.contains("/") ) updateInitWithArray(path.split("/"))

  def updateInitWith(req: HSReq) = {
    updateInit(req.getParameter("pc"), req.getParameter("init"), req.getParameter("npc"))
    updateInitByRest(req.getRequestURI.replaceFirst("/shadow/",""))
  }

  def sortAndDiplay(resp: HSResp, gmView: Boolean) = {
    val sortedMap = ListMap(map.toSeq.sortBy(_._2):_*).toSeq.reverse
    for ( (pc,(init, isNpc) ) <- sortedMap )
      if ( (isNpc && gmView) || ! isNpc )
        resp.getWriter().printf("%-8s: %s\n", pc, init + calculateExtraPasses(init))
  }

  def doPcDelete(req: HSReq, resp: HSResp):Unit = {
    val pcToDelete = req.getParameter("delete")
    if ( pcToDelete != null && ! "".equals(pcToDelete) && map.contains(pcToDelete) )
      map = map.-(pcToDelete)
  }

  override def doPut(req: HSReq, resp: HSResp) =  doPost(req,resp)

  override def doPost(req: HSReq, resp: HSResp) =  updateInitWith(req)

  override def doGet(req: HSReq, resp: HSResp ) = {
    updateInitWith(req)
    doDelete(req,resp)
    doPcDelete(req,resp)

    resp.getWriter().println("Initiative Roster:")
    resp.getWriter().println("==================")
    resp.getWriter().println("")
    sortAndDiplay(resp, ( req.getParameter("gm") != null ) )
    resp.setCharacterEncoding("UTF-8")
    resp.setContentType("text/plain")
  }

  override def doDelete(req: HSReq, resp: HSResp) = {
    deleteRow(req.getParameter("name"))
    deleteRow(req.getRequestURI.replaceFirst("/shadow/",""))
    if ( req.getParameter("reset") != null )
      map = resetMap
  }
}
